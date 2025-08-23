# Portfolio/Blog Website

Using the following technologies:
**Website**

- S3: Hosts static Next.js build files and serves them directly to CloudFront
- CloudFront: Caches and delivers website content globally with low latency
- Route 53: Manages DNS records and routes traffic to CloudFront distribution
- ACM: Provides and auto-renews SSL/TLS certificates for HTTPS
- CloudWatch: Collects metrics from CloudFront and creates monitoring dashboards
- IAM: Defines permissions for GitHub Actions deployment and service access
- Budgets: Sets spending alerts and tracks AWS costs across all services
  **Serverless Contact/Newsletter System:**
- Lambda: Processes form submissions and sends newsletter emails
- DynamoDB: Stores subscriber data and tracks email delivery status
- SQS: Queues email processing tasks for reliable async delivery
- SNS: Sends notifications about new subscribers and system alerts
- IAM: Grants Lambda functions minimal required permissions to other services
  **Analytics Data Pipeline:**
- Lambda: Processes CloudFront access logs and transforms data for storage
- RDS: Stores structured analytics data for complex queries and reporting
- DynamoDB: Tracks real-time visitor sessions and page view counters
- SQS: Buffers log processing tasks to handle traffic spikes smoothly
- CloudWatch: Monitors pipeline performance and triggers scaling alerts
- IAM: Manages cross-service permissions for data flow automationn
