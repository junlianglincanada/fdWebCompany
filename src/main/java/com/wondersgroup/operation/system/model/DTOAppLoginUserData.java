package com.wondersgroup.operation.system.model;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;
import com.wondersgroup.operation.util.security.LoginUser;

/**
 *
 * @author wanglei
 */
public class DTOAppLoginUserData {
    private Integer id ;//账户id
    private String userName;
    private Integer personId;//个人id
    private String name ;
    private String jobRole;
    private String jobTitle;
    private String email;
    private String mobilePhone;
    private String phone;
    private Integer companyId;
    private Integer isPhoneReg;
    
  

    public DTOAppLoginUserData() {
    }

    public static DTOAppLoginUserData createByEntity(  AppLoginUser sysUser ) {
        DTOAppLoginUserData dtoInstance = null;
        if (sysUser != null) {
            dtoInstance = new DTOAppLoginUserData();
            dtoInstance.setUserName(sysUser.getUsername());
            ComEmployee comEmployee=sysUser.getEmp();
            if(comEmployee!=null){
                dtoInstance.setName(comEmployee.getPersonName());
                dtoInstance.setJobRole(comEmployee.getJobRole());
                dtoInstance.setJobTitle(comEmployee.getJobTitle());
                dtoInstance.setEmail(comEmployee.getEmail());
                dtoInstance.setPhone(comEmployee.getPhone());
                dtoInstance.setMobilePhone(comEmployee.getMobilePhone());
                dtoInstance.setPersonId(comEmployee.getPersonId());
                dtoInstance.setIsPhoneReg(comEmployee.getIsPhoneReg());
            }
            dtoInstance.setId(sysUser.getId());
        }
        return dtoInstance;
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public Integer getCompanyId() {
		return companyId;
	}

	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}

	public Integer getIsPhoneReg() {
		return isPhoneReg;
	}

	public void setIsPhoneReg(Integer isPhoneReg) {
		this.isPhoneReg = isPhoneReg;
	}

}
