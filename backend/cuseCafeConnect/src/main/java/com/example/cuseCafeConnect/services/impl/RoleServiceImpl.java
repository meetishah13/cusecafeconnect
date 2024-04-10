package com.example.cuseCafeConnect.services.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.cuseCafeConnect.models.Roles;
import com.example.cuseCafeConnect.repositories.RoleRepository;
import com.example.cuseCafeConnect.services.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository;

    @Override
    public List<Roles> getAllRoles() {
        return roleRepository.findAll();
    }

    @Override
    public Roles getRoleById(int roleID) {
        return roleRepository.findById(roleID).orElse(null);
    }

    @Override
    public Roles createRole(Roles role) {
        return roleRepository.save(role);
    }

    @Override
    public Roles updateRole(int roleID, Roles role) {
        Roles existingRole = roleRepository.findById(roleID).orElse(null);
        if (existingRole != null) {
            existingRole.setRoleName(role.getRoleName());
            return roleRepository.save(existingRole);
        }
        return null;
    }

    @Override
    public void deleteRole(int roleID) {
        roleRepository.deleteById(roleID);
    }
}