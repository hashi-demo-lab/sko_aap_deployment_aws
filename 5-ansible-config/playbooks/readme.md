# Pre-requisites

## Ensure RH-certified hub collections are synchronized

## Create custom credentials type

### Steps to Create a Custom Credential Type in AAP  

#### 1. Navigate to Credential Types  
- Log in to **Ansible Automation Platform**.  
- Go to **Infrastructure** → **Credential Types**.  
- Click **Add** to create a new credential type.  

#### 2. Define the Credential Type  
- **Name:** `Custom AAP Credentials` (or any suitable name)  
- **Description:** Credential type containing **AAP password** and **organization admin flag**.  




input_configuration:
```
  fields:
    - id: aap_password
      type: string
      label: "AAP Password"
      secret: true
    - id: app_org_admin_password
      type: string
      label: "AAP Org Admin Password"
      secret: true
```
injector_configuration:
```
  extra_vars:
    aap_password: "{{ aap_password }}"
    app_org_admin_password: "{{ app_org_admin_password }}"
```

## Use custom credentials

### Populate the credentials
- Log in to **Ansible Automation Platform**.  
- Go to **Infrastructure** → **Credential**. 
- Create credential of type  **Custom AAP Credentials**

## Add credentials to job template
- Click **Add** to create a new credential type. 


* Associate credentials to Job Template