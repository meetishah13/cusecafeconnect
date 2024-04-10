package com.example.cuseCafeConnect.services;

import java.util.List;
import com.example.cuseCafeConnect.models.Roles;

public interface RoleService {
    List<Roles> getAllRoles();
    Roles getRoleById(int roleID);
    Roles createRole(Roles role);
    Roles updateRole(int roleID, Roles role);
    void deleteRole(int roleID);
}