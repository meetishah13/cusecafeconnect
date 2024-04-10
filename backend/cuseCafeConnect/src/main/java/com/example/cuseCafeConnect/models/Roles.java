package com.example.cuseCafeConnect.models;

public class Roles {
	private int roleID;
    private String roleName;

    // Constructors
    public Roles() {}

    public Roles(int roleID, String roleName) {
        this.roleID = roleID;
        this.roleName = roleName;
    }

    // Getters and setters
    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}



