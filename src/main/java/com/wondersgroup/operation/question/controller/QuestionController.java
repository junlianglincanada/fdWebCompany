package com.wondersgroup.operation.question.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wondersgroup.data.jpa.entity.QA;
import com.wondersgroup.framework.support.CommonStatusResult;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.framework.util.ErrorMessageConstant;
import com.wondersgroup.operation.question.model.DTOQA;
import com.wondersgroup.operation.question.model.DTOQACreate;
import com.wondersgroup.operation.util.AbstractBaseController;
import com.wondersgroup.service.question.QAService;

@Controller
@RequestMapping("/question")
public class QuestionController extends AbstractBaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(QuestionController.class);
	@Autowired
    private QAService qaService;
	
	@RequestMapping(value = "/createQuestion",method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult createQuestion(@RequestBody DTOQACreate dto) {
//		int companyId=getLoginCompanyId();
		QA qa = DTOQACreate.toEntity(dto);

			qaService.createQA(qa);

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS, qa);
	}
	
	@RequestMapping(value = "/queryQuestion/{pageNo}/{pageSize}",method = RequestMethod.POST)
	@ResponseBody
	public CommonStatusResult queryQuestion(
			@RequestBody Map<String, Object> paramMap,
	
			@PathVariable int pageNo, @PathVariable int pageSize) {
		String keyword = getStringParam(paramMap, "keyword");
		Integer companyId=getIntParam(paramMap, "companyId");
		Integer questionFrom=getIntParam(paramMap, "questionFrom");
        List<DTOQA> list= new ArrayList<>();
		QueryResult queryResult=qaService.queryQA(companyId, questionFrom, -1, keyword, -1,1,pageNo, pageSize);
		List<QA> qalist=queryResult.getResultList();
		if(null!=qalist&&qalist.size()>0){
			for(QA qa:qalist){
				DTOQA dto=DTOQA.toDTO(qa);
				list.add(dto);
			}
			queryResult.setResultList(list);
		}

		return CommonStatusResult.success(ErrorMessageConstant.CODE_SUCCESS,queryResult);
	}

}
