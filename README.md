# Goal
This project is going to build a [Internal Developer Platform](https://internaldeveloperplatform.org/) that off-loads non-functional requirements from application developers as much as possible to 

- Improve the release speed.
- Ensure a decent level of scalability out of box.
- Ensure a decent level of security out of box.
- Provide observability out of box.
- Provide foundation stats for FinOps.

# Definition of a service
A web service's infrastrcture consists of:
- A deployment on the kubernetes runtime.
- Some secrets and configurations, optionally.
- A RDS with default configurations, optionally.
- A domain, a LB and a TLS certificate, optionally.
- A CDN distribution and a WAF, optionally.
- A S3 bucket.
- Provision or access to other resources are supported but not provided out of box.

Other workloads, like machine learning training, are not covered.

# Requirements to the platform
- Onboarding of a new service should require only one and only one PR to this repo. Anything more than this is an exception.

- The same apply to a release of an existing web service.

- Any traffic across servers should be encrypted.

- Communication between 2 services/components should be authenticated and authorized.

- Service discovery should work the same way within a kubernetes cluster or across clusters.

# Requirements to the services
- A web service should  
    - Listen on port 80.
    - Provide a health-check endpoint on 81.
    - Be able to exit gracefully on signal SITINT.
    - Collect metrics and logs of the application.
    
- A web service should NOT  
    - Use AK/SK to access other cloud resources
    - Use local file system as permanent storage.

- A web service is encouraged to  
    - Use object storage as the primary storage for non-structured data.
    - Use PostgreSQL as the primary storage for structured data.
