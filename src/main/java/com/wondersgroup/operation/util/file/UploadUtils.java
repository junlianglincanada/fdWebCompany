package com.wondersgroup.operation.util.file;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.swing.event.ListSelectionEvent;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.web.multipart.MultipartFile;

import com.wondersgroup.data.jpa.entity.Attachment;
import com.wondersgroup.framework.common.AttachmentService;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ConfigPropertiesUtil;

@Component
public class UploadUtils {
	@Autowired
	private AttachmentService attachmentService;
	public static Long maxUploadSize;

	static {
		try {
			String maxSizeString = ConfigPropertiesUtil.getValue("max_import_file_size");
			maxUploadSize = Long.parseLong(maxSizeString);
		} catch (NumberFormatException e) {
			maxUploadSize = new Long(1 * 1024 * 1024);
		}
	}

	// 判断文件数组总大小是否合法
	public boolean checkFilesSize(List<MultipartFile> files, int[] indexs, Long tempMaxFileSize) {
		if (tempMaxFileSize == null || tempMaxFileSize < 1) {
			tempMaxFileSize = maxUploadSize;
		}
		long totalSize = 0;
		if (CollectionUtils.isNotEmpty(files)) { // 遍历指定文件
			for (int i = 0; i < indexs.length; i++) {
				int j = indexs[i];
				MultipartFile file = files.get(j);
				long size = file.getSize();
				totalSize = size + totalSize;
			}
		} else {// 遍历所有文件
			for (MultipartFile file : files) {
				long size = file.getSize();
				totalSize = size + totalSize;
			}
		}
		return totalSize <= tempMaxFileSize;
	}

	public void uploadFiles(int objId, Map<String, String> uploadTypeToAttachTypeMap, Map<String, List<MultipartFile>> fileMap, List<String> singleImageTypes,
			LinkedMultiValueMap<String, Attachment> resultMap, Integer companyId) {
		// 需要更新的类型
		Set<String> updateTypes = fileMap.keySet();
		// 所有的的上传类型
		Set<String> uploadTypes = uploadTypeToAttachTypeMap.keySet();
		// 只允许有一张的附件，需要删除旧数据
		if (CollectionUtils.isNotEmpty(updateTypes)) {
			for (String type : updateTypes) {
				if (singleImageTypes.contains(type)) {
					if(StringUtils.isNotEmpty(uploadTypeToAttachTypeMap.get(type))){
					attachmentService.deleteAllAttFiles(uploadTypeToAttachTypeMap.get(type), objId);
					}
				}
			}
		}
		// 得到可能的上传类型 uplaodType ;如果需要上传,然后找到对应的附件类型 attachType,上传.
		for (Iterator<String> iterator = uploadTypes.iterator(); iterator.hasNext();) {
			String uploadType = iterator.next();
			List<MultipartFile> files = fileMap.get(uploadType);
			if (CollectionUtils.isNotEmpty(files)) {
				// 获取上传类型对应的附件类型
				String attachType = uploadTypeToAttachTypeMap.get(uploadType);
				for (MultipartFile file : files) {
					Attachment att = attachmentService.uploadAttFile(companyId, attachType, objId, file.getOriginalFilename(), "", new Date(), file);
					if (resultMap != null) {
						resultMap.add(uploadType, att);
					}
				}
			}
		}
	}
	
	
	public List<Attachment> queryAttFile(String attObjectType, Object attObjectId, String sortBy, String sortDirection){
		QueryResult<Attachment> qr = attachmentService.queryAttFile(attObjectType, attObjectId, sortBy, sortDirection);
		if(qr!=null && qr.getResultList()!=null){
			return qr.getResultList();
		}else{
			return new ArrayList<Attachment>();
		}
	}
}
