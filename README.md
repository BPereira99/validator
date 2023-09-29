
# ESVA MODULE
## Summary

This document describes the deployment of the ESVA Module and its endpoints.
  
## Deployment

Each partner is responsible for its own instalation of this module in their own machines. To install the module, 5 steps are required for the reader to make:

### 1. Create the Home Folder

In your machine, create a home directory for the module in your `/data` folder called "esva".

E.g.: `mkdir /data/esva`

### 2. Place the needed certificates

You will need to have 2 sets of certificates:

- the certificate, public and private key to perform the HTTP-signature requests to your EWP node;

- the SSL certificates for NGINX. This set should be generated by you.

You will need to create two directories inside the `/data/esva`:

- "ewp_certs" will contain the EWP node certificate set. These files ought to follow the name schema of your institution schac_code followed by the file extension (e.g. example.pt.crt, example.pt.key, example.pt.pub);

- "ssl_certs" will contain the NGINX certificate set. The certificate file must be named as "fullchain.pem" and the key must be named "privkey.pem"

### 3. Clone the Repository and fill in the Environment Variables

Clone the repository in the `/data/esva` directory and check the ".env.example" file inside the repository and follow its guidelines, adjusting the variables to your specific needs. For that, create a .env file in the repository folder you cloned and fill it in with the variables adjusted to you.

### 4. Privacy Policy
To properly use ESVA, the Privacy Policy needs to be written and accessed at will.
To do this, the following steps need to be performed:
1. Write your Privacy Policy. You can do this in two ways:
	a.  Upon cloning the repository, the file "ESVA_Privacy_Policy_template.pdf" should be available in the home folder of the repository. You can use it as a template for your own Privacy Policy.
	b. You can write your own Privacy Policy according to the needs of your own university.
2. Name your file "privacy-policy.pdf"
3. Place it in the home folder of the repository (`/data/esva/validador`)

If you perform these steps, the installation script will place your file in a folder where the User Interface can access it. After installing ESVA, the Privacy Policy can be accessed in the ESVA main page upon clicking the link in the sentence "When using this validator users are acknowledging and accepting the  **privacy policy**."

### 5. Run the installation script

Finally, in order to set up the containers and run the program, run one of the scripts in the "deployment" folder.

There is a script that compiles the code in the development or production branch. You must be working on the respective branch to run the script (e.g.`git checkout development` before running the buildContainersDevelopment.sh script).

After you run the script, the containers will be up and you will be able to use ESVA module.

If you cannot run the script, give it executable permission (e.g. `chmod +x <script>`)

## Notes
### Logs Access
Logs can be accessed in the port 4000 with endpoint "/logs". Thus, if your DNS is esva.example.com, you can access the logs in https://esva.example.com:4000/logs.

This GET request will list the logs in a JSON list format. Access to the logs should be limited to the technical team.
  
You can filter the logs using the following optional parameters:


*  **page (number):** this will filter the page of the log list. If not specified, the default is 1. The logs are shown in sets of 10 entries. Thus, if the value is 1, the logs fetched are from entry 0 to 9. If the value is 2, the logs fetched are from entry 10 to 19. And so on.
*  **since (string):** this will list the logs beginning in the specific time frame. Write this value in the following format: "YYYY-MM-DD HH:MM:SS" *(e.g. 2023-08-10 08:01:58)*
*  **until (string):** this will list the logs until a specific time frame. Write this value in the following format: "YYYY-MM-DD HH:MM:SS" *(e.g. 2023-08-10 09:01:58)*
*  **ip (string):** this will filter the logs by the IPv4 address from where the request was executed *(e.g. 172.165.1.45)*
*  **browser (string):** this will filter the logs by the browser from where the request was executed *(e.g. Chrome, Firefox, etc)*
*  **operating_system (string):** this will filter the logs by the operating system from where the request was executed *(e.g. Windows, Mac OS X, etc)*
*  **receivingendpoint (string):** this will filter the logs by the called endpoint. You can add the '/' character or not *(e.g. 'receivingendpoint=/ola' or you can write 'receivingendpoint=ola')*
*  **receivingparameterscontains (string):** this will filter the logs wherein the request parameters contain part of or the entire string you specify *(e.g. you can write a mobility id, a sending SCHAC code, etc)*
*  **requestsperformedcontains (string array):** this will filter the logs wherein the ESVA attribute matching process successfully called the EWP URL specified in this parameter *(e.g. https://esva.example.com/institutions. If you write this and logs are listed, it means those requests ended up calling this "institutions" endpoint to validate and match attributes with the signatures).* You may specify as many "requestsperformedcontains" query parameters as you wish. Please note that the URLs must be complete, meaning you cannot write part of the URL.
*  **responsestatus (string):** this will filter the logs that were successful or not. Write "true" if you want to list the logs that ended up in a success or write "false" otherwise.
*  **responsemessagecontains (string):** this will filter the logs that contain, in any point of the response message, the value you specify. For example, you can write the name or email of a person and it will fetch the responses that contain such values.

A request with all these filters should look something like the following:

- https://esva.example.pt:4000/logs?since=2023-08-10%2008:00:50&until=2023-08-10%2009:00:50&ip=172.165.1.45&browser=Chrome&operating_system=Windows&receivingendpoint=ola&receivingparameterscontains=123&requestsperformedcontains=https://example.com/ounits&requestsperformedcontains=https://partne.com/institutions&responsestatus=true&responsemessagecontains=John%20Doe