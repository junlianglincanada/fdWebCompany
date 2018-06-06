package com.wondersgroup.operation.system.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.ComEmployee;

/**
 *
 * @author wanglei
 *
 */
public class DTOLoginUserQueryData {

	private Integer id;
	private String username;
	private String personName;//姓名
	private String mobilePhone;//手机
	private String phone;//电话
	private String email;//邮箱
	private String jobRole; //岗位
    

    public DTOLoginUserQueryData() {

    }

    public static DTOLoginUserQueryData createByEntity(AppLoginUser entity) {
        DTOLoginUserQueryData dto = null;
        if (entity != null) {
            dto = new DTOLoginUserQueryData();
            dto.setId(entity.getId());
            dto.setUsername(entity.getUsername());
            ComEmployee emp = entity.getEmp();
			dto.setPersonName(emp.getPersonName());
			dto.setMobilePhone(emp.getMobilePhone());
			dto.setPhone(emp.getPhone());
			dto.setEmail(emp.getEmail());
			dto.setJobRole(emp.getJobRole());
        }
        return dto;
    }

    public static List<DTOLoginUserQueryData> createListByEntities(Collection<AppLoginUser> domainInstanceList) {
        List<DTOLoginUserQueryData> list = new ArrayList<DTOLoginUserQueryData>();
        if (domainInstanceList != null) {
            for (AppLoginUser domainInstance : domainInstanceList) {
                DTOLoginUserQueryData data = createByEntity(domainInstance);
                if (data != null) {
                    list.add(data);
                }
            }
        }
        return list;
    }

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getJobRole() {
		return jobRole;
	}

	public void setJobRole(String jobRole) {
		this.jobRole = jobRole;
	}



}
