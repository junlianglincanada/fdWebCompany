package com.wondersgroup.operation.util.file;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.wondersgroup.framework.support.FoodException;
import com.wondersgroup.framework.util.FoodConstant;

/**
 * 监听上传进度
 *
 * @author wanglei
 */
public class FileUploadListener implements ProgressListener {

    @Override
    public void update(long bytesRead, long contentLength, int items) {
        try {
            ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
            HttpServletRequest request = attr.getRequest();
            String containfile = request.getHeader("containfile");
            if (containfile != null && !containfile.isEmpty()) {
                HttpSession session = attr.getRequest().getSession(false);
                if (session != null) {
                    Integer flag = (Integer) session.getAttribute(FoodConstant.UPLOAD_BREAK_OFF);
                    if (flag != null && flag == FoodConstant.UPLOAD_BREAK_OFF_FLAG) {
                        //发现中断标识, 抛出异常中止上传
                        throw FoodException.returnException("000012");
                    }
                    FileUploadProgress progress = (FileUploadProgress) session.getAttribute(FoodConstant.UPLOAD_PROGRESS_SESSION_NAME);
                    if (progress != null) {
                        progress.update(bytesRead, contentLength, items);
                    }
                }
            }
        } catch (Exception e) {
            if (e instanceof FoodException) {
                throw e;
            }
            LoggerFactory.getLogger(FileUploadListener.class).info(null, e);
        }
    }

}
