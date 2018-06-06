package com.wondersgroup.operation.system.model;

import java.util.Date;

import org.springframework.util.StringUtils;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.util.EncodeUtils;

/**
 *
 * @author wanglei
 */
public class DTOAppLoginUserEditData {
    private Integer id;//账号id
    private Integer personId;//个人id
    private String name ;
    private String jobRole;
    private String jobTitle;
    private String email;
    private String mobilePhone;
    private String phone;

    public DTOAppLoginUserEditData() {
    }

    public static AppLoginUser toEntity(AppLoginUser entityInstance, DTOAppLoginUserEditData dtoInstance, ComEmployee emp){
        if(entityInstance!=null){

               emp.setPersonName(dtoInstance.getName());
               emp.setJobRole(dtoInstance.getJobRole());
               emp.setJobTitle(dtoInstance.getJobTitle());
               emp.setPhone(dtoInstance.getPhone());
               emp.setMobilePhone(dtoInstance.getMobilePhone());
               emp.setEmail(dtoInstance.getEmail());
               entityInstance.setEmp(emp);
           

      
        }
        return entityInstance;
    }


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getJobRole() {
		return jobRole;
	}

	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}
    

}
