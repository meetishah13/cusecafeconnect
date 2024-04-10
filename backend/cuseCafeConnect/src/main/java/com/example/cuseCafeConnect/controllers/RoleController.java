package com.example.cuseCafeConnect.controllers;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.cuseCafeConnect.models.Roles;
import com.example.cuseCafeConnect.services.RoleService;

@RestController
@RequestMapping("/api/roles")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @GetMapping
    public ResponseEntity<List<Roles>> getAllRoles() {
        List<Roles> roles = roleService.getAllRoles();
        return new ResponseEntity<>(roles, HttpStatus.OK);
    }

    @GetMapping("/{roleID}")
    public ResponseEntity<Roles> getRoleById(@PathVariable int roleID) {
        Roles role = roleService.getRoleById(roleID);
        if (role != null) {
            return new ResponseEntity<>(role, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    public ResponseEntity<Roles> createRole(@RequestBody Roles role) {
        Roles createdRole = roleService.createRole(role);
        return new ResponseEntity<>(createdRole, HttpStatus.CREATED);
    }

    @PutMapping("/{roleID}")
    public ResponseEntity<Roles> updateRole(@PathVariable int roleID, @RequestBody Roles role) {
        Roles updatedRole = roleService.updateRole(roleID, role);
        if (updatedRole != null) {
            return new ResponseEntity<>(updatedRole, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{roleID}")
    public ResponseEntity<Void> deleteRole(@PathVariable int roleID) {
        roleService.deleteRole(roleID);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}