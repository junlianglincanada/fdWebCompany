package com.wondersgroup.operation.util.security;

import static com.wondersgroup.data.jpa.entity.AppLoginUser.TYPE_EMP;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.BooleanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wondersgroup.data.jpa.entity.AppLoginUser;
import com.wondersgroup.data.jpa.entity.AppPermission;
import com.wondersgroup.data.jpa.entity.AppRole;
import com.wondersgroup.framework.support.QueryResult;
import com.wondersgroup.service.company.ComRelationshipService;
import com.wondersgroup.service.empuser.RestaurantEmployeeLoginService;
import com.wondersgroup.service.empuser.RestaurantEmployeeService;
import com.wondersgroup.service.monitorFace.MonitorFaceService;
import com.wondersgroup.service.sys.SystemUserLoginService;

@Component
public class UserService implements UserDetailsService {

	@Autowired
	private SystemUserLoginService systemUserLoginService;
	@Autowired
	private RestaurantEmployeeService comEmployeeService;
	@Autowired
	private RestaurantEmployeeLoginService restaurantEmployeeLoginService;
	@Autowired
	private ComRelationshipService comRelationshipService;
	@Autowired
	private MonitorFaceService monitirService;

	
	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String username) {
		LoginUser loginUser = null;

		AppLoginUser user = restaurantEmployeeLoginService.login(username, null, -1, TYPE_EMP);
		if (user != null) {

			System.out.println(user.getEmp().getPersonName());
			System.out.println(user.getEmp().getCompany().getCompanyName());
			QueryResult<AppRole> roleQueryResult = restaurantEmployeeLoginService.queryAppRolesByAppLoginUserId(user.getId(), -1, -1);
			List<AppRole> roles = null;
			if (roleQueryResult != null && roleQueryResult.getResultList() != null) {
				roles = roleQueryResult.getResultList();
			}
			System.out.println(user.getId());
			List<AppPermission> permisssionList = restaurantEmployeeLoginService.getAllPermissionsByLoginUserId(user.getId());
//			int hasBranch = comRelationshipService.hasComRelationship(user.getEmp().getCompany().getCompanyId());
//			int hasTrunk = comRelationshipService.hasHeadquarters(user.getEmp().getCompany().getCompanyId());
			int hasMonitor = monitirService.hasMonitor(user.getEmp().getCompany().getRestaurant().getCateringCert())
					+ monitirService.hasMonitor(user.getEmp().getCompany().getRestaurant().getFoodBusinessCert());
			loginUser = new LoginUser(user.getUsername(), user.getPassword(), BooleanUtils.toBooleanObject(user.getEnabled()), true, true, true, getAuthorities(permisssionList));
//			loginUser.setHasBranch(hasBranch);
//			loginUser.setHasTrunk(hasTrunk);
			loginUser.setHasMonitor(hasMonitor);
			loginUser.setAppLoginUser(user);
			loginUser.setAppPermissionsList(permisssionList);
			loginUser.setAppRolesList(roles);
		}
		return loginUser;
	}

	public Collection<GrantedAuthority> getAuthorities(List<AppPermission> permissionList) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		if (null != permissionList) {
			for (AppPermission permission : permissionList) {
				authList.add(new GrantedAuthorityImpl(permission.getPermissionId()));
			}
		}
		authList.add(new GrantedAuthorityImpl("ROLE_TEST"));
		return authList;
	}
}
