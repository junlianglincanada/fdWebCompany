package com.wondersgroup.operation.system.model;

/**
 *
 * @author wanglei
 */
public class DTOAppLoginUserPasswordChangeData {
    private Integer companyUserId;
    private String currentPassword;
    private String newPassword;

    public Integer getCompanyUserId() {
        return companyUserId;
    }

    public void setCompanyUserId(Integer companyUserId) {
        this.companyUserId = companyUserId;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
    }
    
}
