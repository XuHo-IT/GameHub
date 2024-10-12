package Model;

public class UserModel {
    private String id;
    private String email;
    private String phone;
    private String dateOfBirth;
    private String address;
    private String name;
    private String password;
    private String photoUrl;  
    private String status;
    private String role;
    // Getters and Setters
    public String getId() { return this.id; }
    public void setId(String id) { this.id = id; }

    public String getEmail() { return this.email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getDateOfBirth() { return this.dateOfBirth; }
    public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    
    public String getAddress() {return this.address;}
    public void setAddress(String address) {this.address = address;}

    public String getName() { return this.name; }
    public void setName(String name) { this.name = name; }

    public String getPassword() { return this.password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhotoUrl() { return this.photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }
    
    public String getStatus() {return this.status;}
    public void setStatus(String status) {this.status = status;}
    public String getRole(){return this.role;}
    public void setRole(String role) {this.role = role;}
    @Override
public String toString() {
    return "User{" +
            "id='" + id + '\'' +
            ", email='" + email + '\'' +
            ", phone='" + phone + '\'' +
            ", dateOfBirth='" + dateOfBirth + '\'' +
            ", address=" + address + '\'' +
            ", name='" + name + '\'' +
            ", password='" + password + '\'' +
            ", photoUrl='" + photoUrl + '\'' +
            '}';
}

}
