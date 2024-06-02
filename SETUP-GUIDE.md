# SETUP GUIDE


**( DISCLAIMER: FOR THIS GUIDE I ASSUME YOU HAVE ZERO KNOWLEDGE OF THE API, THUS MAY APPRECIATE GUIDANCE )**


## STEP 1: CREATE YOUR DROPBOX APP

- **1.1) Go to https://www.dropbox.com/developers/apps/create & create your app like this:**

![1 1](https://github.com/ConzZah/boxdrop_up/assets/69615452/4312c0c3-4161-4387-abf9-18ea76c86cf9)

**( ^ NOTE!! IT'S BAD PRACTICE TO ALLOW FULL DROPBOX ACCESS, UNLESS YOU REALLY NEED IT ALWAYS CHOOSE THE APP FOLDER OPTION!!)**


- **1.2) Name your app whatever you want and click on Create app ( in this example i named mine "boxdrop_test_1" )**

![1 2](https://github.com/ConzZah/boxdrop_up/assets/69615452/886d83d4-964c-4c0f-8f78-d4d6e5a563a6)



## STEP 2: SET PERMISSIONS FOR YOUR APP

- **2.1) Navigate to the Permissions Tab:**

![2 1](https://github.com/ConzZah/boxdrop_up/assets/69615452/6be9ee28-ef87-4c6a-8ed8-aa3de1251522)

- **2.2) Then scroll down until you see "Files and folders & Tick "files.content.write":**

![2 2](https://github.com/ConzZah/boxdrop_up/assets/69615452/ba758eec-ca1e-45ba-9e44-048116ab7ac5)

- **2.3) After you're done, confirm your changes by clicking "Submit":**

![2 3](https://github.com/ConzZah/boxdrop_up/assets/69615452/a7f3a223-cba0-420d-b223-8d272a1c1560)

### **NOTE: "files.content.write" is the only Permission your app requires to work.**


## STEP 3: MAKE NOTES OF YOUR APP KEYS

- **3.1) Navigate back to the Settings Tab:**

![3 1](https://github.com/ConzZah/boxdrop_up/assets/69615452/33cc818d-5484-4d9d-9614-4e590149e138)

- **3.2) Take Notes of your keys, you'll need them in the next step.**

![3 2](https://github.com/ConzZah/boxdrop_up/assets/69615452/f9aae57e-21d5-4784-a2cd-15d0b72fff66)




## STEP 4: ( finally ) SETUP BOXDROP:
- **4.1) Input your keys, you will then get a Link that looks something like this:**

![4 1](https://github.com/ConzZah/boxdrop_up/assets/69615452/f1d9d0eb-2809-4164-b4ad-69da8b80bd05)

- **4.2) Click on Allow and copy the Access Code:**

![4 2](https://github.com/ConzZah/boxdrop_up/assets/69615452/91cd5a9d-b6e1-458f-9104-d609ff42ddfc)

![4 2 2](https://github.com/ConzZah/boxdrop_up/assets/69615452/9fbeecc1-8fe9-4d9b-9e49-23f525e930fd)

- **4.3) Once copied, go back to BOXDROP, paste the Access Code and hit ENTER:**

![4 3](https://github.com/ConzZah/boxdrop_up/assets/69615452/28584336-8680-4c13-924b-16a0e5b83f57)

**^ this will generate a refresh token & save it to ~/boxdrop_config**

### IMPORTANT STUFF TO NOTE:

**( you can revoke your current refresh token by simply deleting your config files & repeating step 4 )**

**your config files ( app key, app secret & your refresh token ) are stored in: ~/boxdrop_config**

### **Never, and i mean it, NEVER SHARE YOUR REFRESH TOKEN!! ( for obvious reasons ).**

## END OF SETUP

 **Cheers,
 ConzZah**
