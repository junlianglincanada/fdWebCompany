package com.wondersgroup.operation.util.file;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.wondersgroup.framework.util.FoodConstant;

/**
 * 上传文件拦截器
 *
 * @author wanglei
 */
public class FileUploadMultipartResolver extends CommonsMultipartResolver {

    private FileUploadListener fileUploadListener;

    @Override
    protected FileUpload newFileUpload(FileItemFactory fileItemFactory) {
        return super.newFileUpload(fileItemFactory);
    }

    @Override
    protected MultipartParsingResult parseRequest(HttpServletRequest request) throws MultipartException {
        String encoding = determineEncoding(request);
        FileUpload fileUpload = prepareFileUpload(encoding);

        //如果有文件上传, 需要客户端headers中包含有containfile信息
        String containfile = request.getHeader("containfile");
        if (containfile != null && !containfile.isEmpty()) {
            //注入监听
            if (fileUploadListener == null) {
                fileUploadListener = new FileUploadListener();
            }
            fileUpload.setProgressListener(fileUploadListener);

            HttpSession session = request.getSession(true);
            if (session != null) {
                //无法支持在同一个客户端使用多线程的方式同时上传文件...
                session.removeAttribute(FoodConstant.UPLOAD_BREAK_OFF); //移除中断标识
                //移除逻辑处理相关的进度
                session.removeAttribute(FoodConstant.PROGRESS_INPUT_BATCH_IMPORT); //移除进货台账导入进度
                session.removeAttribute(FoodConstant.PROGRESS_OUTPUT_BATCH_IMPORT); //移除配送台账导入进度
                session.removeAttribute(FoodConstant.PROGRESS_SUPPLIER_IMPORT); //移除供应商导入进度
                session.removeAttribute(FoodConstant.PROGRESS_INPUT_MAT_IMPORT); //移除采购品导入进度
                session.removeAttribute(FoodConstant.PROGRESS_RECEIVER_IMPORT); //移除收货商导入进度
                session.removeAttribute(FoodConstant.PROGRESS_OUTPUT_MAT_IMPORT); //移除产出品导入进度
                session.removeAttribute(FoodConstant.PROGRESS_COM_EMP_IMPORT); //移除从业人员导入进度
                session.removeAttribute(FoodConstant.PROGRESS_COM_EMP_LICENCE_IMPORT); //移除从业人员证照导入进度
                //把上传进度信息保存在session中
                FileUploadProgress progress = (FileUploadProgress) session.getAttribute(FoodConstant.UPLOAD_PROGRESS_SESSION_NAME);
                if (progress != null) {
                    progress.rest();
                }
            }
        }

        try {
            List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
            return parseFileItems(fileItems, encoding);
        } catch (FileUploadBase.SizeLimitExceededException ex) {
            throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
        } catch (FileUploadException ex) {
            throw new MultipartException("Could not parse multipart servlet request", ex);
        }
    }

    private String determineEncoding(String contentTypeHeader, String defaultEncoding) {
        if (!StringUtils.hasText(contentTypeHeader)) {
            return defaultEncoding;
        }
        MediaType contentType = MediaType.parseMediaType(contentTypeHeader);
        Charset charset = contentType.getCharSet();
        return (charset != null ? charset.name() : defaultEncoding);
    }

    @Override
    protected MultipartParsingResult parseFileItems(List<FileItem> fileItems, String encoding) {
        MultiValueMap<String, MultipartFile> multipartFiles = new LinkedMultiValueMap<String, MultipartFile>();
        Map<String, String[]> multipartParameters = new HashMap<String, String[]>();
        Map<String, String> multipartParameterContentTypes = new HashMap<String, String>();

        // Extract multipart files and multipart parameters.
        for (FileItem fileItem : fileItems) {
            if (fileItem.isFormField()) {
                String value;
                String partEncoding = determineEncoding(fileItem.getContentType(), encoding);
                if (partEncoding != null) {
                    try {
                        value = fileItem.getString(partEncoding);
                    } catch (UnsupportedEncodingException ex) {
                        if (logger.isWarnEnabled()) {
                            logger.warn("Could not decode multipart item '" + fileItem.getFieldName()
                                    + "' with encoding '" + partEncoding + "': using platform default");
                        }
                        value = fileItem.getString();
                    }
                } else {
                    value = fileItem.getString();
                }
                String[] curParam = multipartParameters.get(fileItem.getFieldName());
                if (curParam == null) {
                    // simple form field
                    multipartParameters.put(fileItem.getFieldName(), new String[]{value});
                } else {
                    // array of simple form fields
                    String[] newParam = StringUtils.addStringToArray(curParam, value);
                    multipartParameters.put(fileItem.getFieldName(), newParam);
                }
                multipartParameterContentTypes.put(fileItem.getFieldName(), fileItem.getContentType());
            } else {
                // multipart file field
                UTFFileNameMultipartFile file = new UTFFileNameMultipartFile(fileItem);
                multipartFiles.add(file.getName(), file);
                if (logger.isDebugEnabled()) {
                    logger.debug("Found multipart file [" + file.getName() + "] of size " + file.getSize()
                            + " bytes with original filename [" + file.getOriginalFilename() + "], stored "
                            + file.getStorageDescription());
                }
            }
        }
        return new MultipartParsingResult(multipartFiles, multipartParameters, multipartParameterContentTypes);
    }
}
