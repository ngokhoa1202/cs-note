# First Day Questions - ST Engineering

#career #onboarding #questions #ST-Engineering

**Date**: December 8, 2025
**Position**: Mid-Level Java Developer
**Purpose**: Structured questions to ask during onboarding

---

## How to Use This Document

### Timing Strategy
- ✅ **Morning**: Technical setup and immediate needs
- ✅ **Midday**: Team structure and workflow questions
- ✅ **Afternoon**: Development practices and learning resources
- ❌ **Don't**: Ask everything at once - pace yourself throughout the day
- ❌ **Don't**: Ask questions already answered in onboarding materials

### Question Priority
- 🔴 **P0 (Ask Today)**: Critical for getting started
- 🟡 **P1 (Ask This Week)**: Important for first tasks
- 🟢 **P2 (Ask First Month)**: Good to know for long-term success

---

## P0: Critical Questions (Ask on Day 1)

### 1. Technical Stack & Environment 🔴

#### Development Environment
- [ ] **Q1.1**: What IDE does the team use? (IntelliJ IDEA, Eclipse, VS Code?)
  - Is there a company license?
  - Are there shared IDE settings or plugins required?
  - Any code style configurations to import?

- [ ] **Q1.2**: What Java version are we using in production?
  - OpenJDK or Oracle JDK?
  - Are we planning any version upgrades soon?
  - Any compatibility constraints I should know about?

- [ ] **Q1.3**: What build tool? (Maven or Gradle?)
  - Which version?
  - Any custom plugins or profiles?
  - Location of settings.xml or build.gradle?

- [ ] **Q1.4**: What application server/runtime?
  - Tomcat, WildFly, JBoss, or embedded?
  - Version and configuration location?

#### Version Control & Collaboration
- [ ] **Q1.5**: How do I access the Git repository?
  - GitHub, GitLab, Bitbucket, or internal?
  - What's my username/access setup process?
  - SSH keys or HTTPS?

- [ ] **Q1.6**: What's the branching strategy?
  - GitFlow, trunk-based, or custom?
  - Naming conventions for branches? (feature/, bugfix/, etc.)
  - Who can merge to main/master?

- [ ] **Q1.7**: How do code reviews work?
  - Review tool (GitHub PR, GitLab MR, Crucible)?
  - Who reviews my code?
  - How many approvals needed?
  - Typical turnaround time?

#### Database Access
- [ ] **Q1.8**: What databases do we use?
  - PostgreSQL, MySQL, Oracle, SQL Server, MongoDB?
  - Versions?
  - How do I access development database?
  - Connection strings and credentials location?

- [ ] **Q1.9**: Do we have local/Docker databases for development?
  - Docker Compose files available?
  - Test data seeding scripts?
  - Database migration tools? (Flyway, Liquibase?)

---

### 2. CI/CD & Deployment Pipeline 🔴

- [ ] **Q2.1**: What CI/CD tool do we use?
  - Jenkins, GitLab CI, GitHub Actions, Azure DevOps?
  - How do I access it?
  - Can I trigger builds manually?

- [ ] **Q2.2**: What's the deployment process?
  - How often do we deploy? (Daily, weekly, per sprint?)
  - Who can deploy to dev/staging/production?
  - Any deployment windows or restrictions?

- [ ] **Q2.3**: What's our container strategy?
  - Docker, Podman, or none?
  - Do we use Docker Compose for local development?
  - Container registry? (Docker Hub, ECR, private registry?)

- [ ] **Q2.4**: What environments do we have?
  - Local → Dev → Staging → Production?
  - How do I deploy to dev environment?
  - URLs for each environment?

---

### 3. Immediate Setup & Access 🔴

- [ ] **Q3.1**: What access do I need to request today?
  - VPN credentials?
  - Jira/Confluence account?
  - Slack/Teams/Communication tool?
  - Email distribution lists?
  - Jenkins access?
  - Database access?
  - Cloud platform access (AWS/Azure)?

- [ ] **Q3.2**: Is there a setup guide or onboarding documentation?
  - Confluence page?
  - README in the repository?
  - Wiki?

- [ ] **Q3.3**: Who is my IT contact for access issues?
  - Name and contact method?
  - Ticketing system?

- [ ] **Q3.4**: What's my work machine setup?
  - Pre-configured or do I set up myself?
  - Admin rights?
  - Required security software?

---

### 4. Team Structure & Communication 🔴

- [ ] **Q4.1**: Who is my direct manager/team lead?
  - Name and contact?
  - Reporting structure?
  - 1-on-1 schedule?

- [ ] **Q4.2**: Who is my onboarding buddy/mentor?
  - Name and contact?
  - How often should we sync?
  - What can I ask them vs escalate to team lead?

- [ ] **Q4.3**: What's our daily/weekly meeting schedule?
  - Daily standup time?
  - Sprint planning, review, retrospective schedule?
  - Any other recurring meetings?

- [ ] **Q4.4**: What communication channels do we use?
  - Slack/Teams channels to join?
  - Email vs chat etiquette?
  - How to indicate I'm blocked or need help?

---

### 5. First Tasks & Expectations 🔴

- [ ] **Q5.1**: What's my first task/ticket?
  - Jira ticket number?
  - Expected completion time?
  - Who can I ask for help?

- [ ] **Q5.2**: What's expected of me in the first week?
  - Complete setup?
  - Fix first bug?
  - Attend meetings only?

- [ ] **Q5.3**: How do I track my work?
  - Jira workflow (To Do → In Progress → Review → Done)?
  - Do I assign tickets to myself?
  - How to log time?

---

## P1: Important Questions (Ask This Week)

### 6. Development Practices & Standards 🟡

#### Coding Standards
- [ ] **Q6.1**: What are our coding standards?
  - Style guide document?
  - Checkstyle, PMD, or SonarQube rules?
  - Are there linting rules that fail builds?

- [ ] **Q6.2**: What's our testing strategy?
  - Required test coverage percentage?
  - Unit tests mandatory?
  - Integration tests required?
  - Do we practice TDD?

- [ ] **Q6.3**: How do we handle dependencies?
  - Internal artifact repository? (Nexus, Artifactory?)
  - Approved libraries list?
  - How to request new dependencies?

#### Documentation
- [ ] **Q6.4**: Where is technical documentation kept?
  - Confluence?
  - README files?
  - Wiki?
  - Code comments expectations?

- [ ] **Q6.5**: Do we write Architecture Decision Records (ADRs)?
  - Format and location?
  - Who approves?

- [ ] **Q6.6**: API documentation practices?
  - Swagger/OpenAPI?
  - Postman collections?
  - Where are they hosted?

---

### 7. Tech Stack Deep Dive 🟡

#### Spring Framework Specifics
- [ ] **Q7.1**: Which Spring projects are we using?
  - Spring Boot version?
  - Spring Cloud components? (Gateway, Eureka, Config Server?)
  - Spring Security for authentication?
  - Spring Batch for batch jobs?

- [ ] **Q7.2**: What's our microservices architecture?
  - How many services?
  - Service discovery mechanism?
  - API Gateway pattern?
  - Communication: REST, gRPC, or both?

#### Messaging & Events
- [ ] **Q7.3**: Do we use message brokers?
  - RabbitMQ, Kafka, or both?
  - For what use cases?
  - Any existing producers/consumers I should study?

- [ ] **Q7.4**: Event-driven architecture?
  - Event sourcing?
  - CQRS pattern?
  - Event schema registry?

#### Caching & Performance
- [ ] **Q7.5**: What caching strategy do we use?
  - Redis, Caffeine, or both?
  - Cache-aside, write-through, or other patterns?
  - Cache invalidation strategy?

- [ ] **Q7.6**: How do we handle database connections?
  - HikariCP settings?
  - Connection pool size?
  - Any known performance bottlenecks?

---

### 8. Monitoring & Operations 🟡

- [ ] **Q8.1**: What monitoring tools do we use?
  - Application Performance Monitoring (APM)?
    - New Relic, Datadog, AppDynamics, Dynatrace?
  - Metrics: Prometheus, CloudWatch, Azure Monitor?
  - Dashboards: Grafana, Kibana, built-in?

- [ ] **Q8.2**: How do we handle logging?
  - Centralized logging? (ELK stack, Splunk, CloudWatch Logs?)
  - Log levels in different environments?
  - How to search production logs?
  - Structured logging format (JSON)?

- [ ] **Q8.3**: What's our alerting strategy?
  - PagerDuty, OpsGenie, or built-in?
  - What triggers alerts?
  - Who's on call?

- [ ] **Q8.4**: Distributed tracing?
  - Jaeger, Zipkin, AWS X-Ray, Azure Application Insights?
  - How to trace requests across services?

---

### 9. Security & Compliance 🟡

- [ ] **Q9.1**: What security practices must I follow?
  - Security scanning tools? (SonarQube, Snyk, Checkmarx?)
  - OWASP guidelines?
  - Security code review requirements?

- [ ] **Q9.2**: How do we handle secrets and credentials?
  - Vault, AWS Secrets Manager, Azure Key Vault?
  - Environment variables?
  - No hardcoded secrets policy?

- [ ] **Q9.3**: Authentication & Authorization
  - JWT, OAuth 2.0, SAML?
  - SSO integration?
  - Role-based access control (RBAC)?

- [ ] **Q9.4**: Data privacy requirements?
  - GDPR, HIPAA, or other compliance?
  - PII handling guidelines?
  - Data retention policies?

---

### 10. Cloud & Infrastructure 🟡

- [ ] **Q10.1**: Which cloud provider?
  - AWS, Azure, GCP, or hybrid?
  - Which region(s)?
  - Multi-cloud strategy?

- [ ] **Q10.2**: What cloud services do we use?
  - **Compute**: EC2, ECS, EKS, Lambda, App Service?
  - **Database**: RDS, DynamoDB, Aurora, Cosmos DB?
  - **Storage**: S3, EBS, Blob Storage?
  - **Networking**: VPC, Load Balancers, API Gateway?

- [ ] **Q10.3**: Infrastructure as Code?
  - Terraform, CloudFormation, ARM templates?
  - Who manages infrastructure?
  - Can developers modify infrastructure?

- [ ] **Q10.4**: Container orchestration?
  - Kubernetes (EKS, AKS, GKE)?
  - Docker Swarm?
  - Nomad?
  - Or just Docker Compose?

---

## P2: Good to Know (Ask in First Month)

### 11. Agile & Project Management 🟢

- [ ] **Q11.1**: What Agile methodology?
  - Scrum, Kanban, or hybrid?
  - Sprint length?
  - Story point estimation process?

- [ ] **Q11.2**: How do we estimate work?
  - Story points, hours, or t-shirt sizes?
  - Planning poker?
  - Who participates in estimation?

- [ ] **Q11.3**: What's our Definition of Done?
  - Code complete?
  - Code reviewed?
  - Tests written?
  - Deployed to staging?
  - Documentation updated?

- [ ] **Q11.4**: How do we handle production bugs?
  - Separate bug fix workflow?
  - Hotfix process?
  - Priority levels?

---

### 12. Career Development 🟢

- [ ] **Q12.1**: What's the career progression path?
  - Mid → Senior → Staff/Lead?
  - What's expected for promotion?
  - When are performance reviews?

- [ ] **Q12.2**: Learning & Development opportunities?
  - Conference budget?
  - Online course subscriptions (Pluralsight, Udemy, O'Reilly)?
  - Certification support?
  - Internal training programs?

- [ ] **Q12.3**: What's the 30-60-90 day expectation?
  - 30 days: Setup and first tasks?
  - 60 days: Independent work?
  - 90 days: Leading small features?

- [ ] **Q12.4**: How often do we have 1-on-1s?
  - Weekly, biweekly, monthly?
  - What's typically discussed?

---

### 13. Business Context 🟢

- [ ] **Q13.1**: What product/service are we building?
  - Target users/customers?
  - Business model?
  - Competitive landscape?

- [ ] **Q13.2**: What are our current priorities?
  - Roadmap for next quarter?
  - Key metrics we're optimizing for?
  - Technical debt vs new features balance?

- [ ] **Q13.3**: Who are our stakeholders?
  - Product managers?
  - Business analysts?
  - How do requirements come in?

- [ ] **Q13.4**: How do we measure success?
  - KPIs for the team?
  - SLAs or SLOs?
  - User satisfaction metrics?

---

### 14. Team Culture & Practices 🟢

- [ ] **Q14.1**: What's the team's working hours?
  - Core hours?
  - Flexible schedule?
  - Remote/hybrid policy?

- [ ] **Q14.2**: How do we handle knowledge sharing?
  - Brown bag sessions?
  - Tech talks?
  - Pair programming culture?
  - Code review as teaching opportunity?

- [ ] **Q14.3**: What's our approach to technical debt?
  - Dedicated time each sprint?
  - Tracked in backlog?
  - How to propose refactoring?

- [ ] **Q14.4**: Team building activities?
  - Social events?
  - Team lunches?
  - Offsites?

---

## Question Tracking

### Day 1 - Asked ✅
<!-- Mark questions as you ask them -->
- [ ] Q1.1 - IDE and setup
- [ ] Q1.5 - Git access
- [ ] Q2.1 - CI/CD tool
- [ ] Q3.1 - Access requests
- [ ] Q4.1 - Manager/team lead
- [ ] Q4.2 - Onboarding buddy
- [ ] Q4.3 - Meeting schedule
- [ ] Q5.1 - First task

**Total Asked**: 0 / 8 priority questions

---

### Week 1 - Asked ✅
<!-- Track throughout the week -->
- [ ] Q6.1 - Coding standards
- [ ] Q6.2 - Testing strategy
- [ ] Q7.1 - Spring stack
- [ ] Q7.3 - Message brokers
- [ ] Q8.1 - Monitoring tools
- [ ] Q8.2 - Logging strategy
- [ ] Q10.1 - Cloud provider
- [ ] Q11.1 - Agile methodology

**Total Asked**: 0 / 8 questions

---

### Month 1 - Asked ✅
<!-- Track throughout the month -->
- [ ] Q12.1 - Career progression
- [ ] Q12.2 - Learning opportunities
- [ ] Q13.1 - Product/business context
- [ ] Q14.2 - Knowledge sharing

**Total Asked**: 0 / 4 questions

---

## Answers & Notes

### Technical Stack Summary
**Date**: _____

**Programming**:
- Java version: _____
- Build tool: _____
- IDE: _____

**Frameworks**:
- Spring Boot version: _____
- Spring Cloud components: _____
- Other frameworks: _____

**Databases**:
- Primary DB: _____
- Version: _____
- Access method: _____

**Messaging**:
- Broker: _____ (RabbitMQ / Kafka / None)
- Use cases: _____

**Cloud**:
- Provider: _____ (AWS / Azure / GCP)
- Main services: _____

**CI/CD**:
- Tool: _____ (Jenkins / GitLab CI / GitHub Actions)
- Access URL: _____

**Monitoring**:
- APM: _____
- Logs: _____
- Metrics: _____

---

### Team Structure
**Date**: _____

**Team Members**:
- Manager: _____
- Tech Lead: _____
- Mentor/Buddy: _____
- Team size: _____

**Communication**:
- Chat platform: _____ (Slack / Teams / Discord)
- Channels to join: _____
- Email lists: _____

**Meetings**:
- Daily Standup: _____ (time)
- Sprint Planning: _____ (day/time)
- Sprint Review: _____ (day/time)
- Retrospective: _____ (day/time)
- Sprint Length: _____ days

---

### Development Workflow
**Date**: _____

**Branching Strategy**:
- Model: _____ (GitFlow / Trunk-based / Custom)
- Branch naming: _____
- Main branch: _____ (main / master / develop)

**Code Review Process**:
- Tool: _____
- Reviewers needed: _____
- Merge permissions: _____

**Testing Requirements**:
- Coverage target: _____%
- Unit tests: _____ (Required / Recommended)
- Integration tests: _____ (Required / Recommended)
- E2E tests: _____ (Required / Recommended)

**Deployment**:
- Environments: _____
- Deploy frequency: _____
- Who can deploy: _____

---

### First Task Details
**Date**: _____

**Task Description**: _____

**Ticket Number**: _____

**Expected Completion**: _____

**Resources**:
- Documentation: _____
- Related code: _____
- Contact for questions: _____

**Acceptance Criteria**:
1. _____
2. _____
3. _____

---

## Questions to Avoid ❌

### Don't Ask These on Day 1
- ❌ "When do I get promoted?" - Too early, focus on learning
- ❌ "Can I work fully remote?" - Unless unclear from offer, wait for settled in
- ❌ "Why did the previous person leave?" - Can seem gossipy
- ❌ "What's wrong with the codebase?" - Negative first impression
- ❌ "Can I refactor everything?" - Too presumptuous
- ❌ "Do we work weekends?" - Implies unwillingness to go extra mile
- ❌ "What's the raise policy?" - Too early, focus on delivering value

### Questions That Show Red Flags
- ❌ Asking same question multiple times (take notes!)
- ❌ Questions already answered in onboarding materials
- ❌ Challenging decisions without context
- ❌ Comparing to "how we did it at my last company"

---

## Good Question Patterns ✅

### Shows Initiative
- ✅ "I noticed we use [technology]. Are there any gotchas I should know about?"
- ✅ "What's the most common mistake new team members make?"
- ✅ "Is there any documentation I can help improve?"
- ✅ "What resources helped you when you started?"

### Shows Business Awareness
- ✅ "Who are our main users and what problems do we solve for them?"
- ✅ "What metrics indicate we're successful?"
- ✅ "How does my work connect to business goals?"

### Shows Technical Depth
- ✅ "I saw we use [pattern]. What led to that architectural decision?"
- ✅ "How do we handle [specific technical challenge]?"
- ✅ "What's our strategy for [scalability/performance/security]?"

### Shows Team Spirit
- ✅ "How can I best contribute to code reviews?"
- ✅ "What knowledge gaps does the team have that I might help fill?"
- ✅ "How do you prefer to receive questions - Slack, email, in-person?"

---

## After Each Conversation

### Immediate Actions
1. ✅ Write down answers in this document
2. ✅ Add action items to todo list
3. ✅ Update your calendar with meetings
4. ✅ Request access to tools mentioned
5. ✅ Thank the person for their time

### End of Day Review
1. ✅ Transfer notes to Obsidian permanent notes
2. ✅ Create task list for tomorrow
3. ✅ Identify unanswered questions to follow up
4. ✅ Reflect on what went well / what to improve

---

## Follow-Up Question Template

When you need to ask follow-up questions:

```
Hi [Name],

Thanks for the [meeting/explanation] earlier about [topic].

I have a quick follow-up question:

[Your specific question]

Context: [Why you're asking / what you're trying to do]

No rush - whenever you have a moment.

Thanks!
Khoa
```

---

## Emergency Contacts

**Fill in during Day 1**:

| Role | Name | Contact | When to Use |
|------|------|---------|-------------|
| Manager | _____ | _____ | Performance, time off, escalations |
| Tech Lead | _____ | _____ | Technical decisions, architecture |
| Mentor/Buddy | _____ | _____ | Daily questions, onboarding |
| DevOps Lead | _____ | _____ | CI/CD, deployment, infrastructure |
| IT Support | _____ | _____ | Access issues, hardware problems |
| HR Contact | _____ | _____ | Benefits, policies, admin |

---

## Key Learnings from Day 1

### Technical Discoveries
**Most Important**: _____

**Surprised by**: _____

**Need to learn**: _____

### Team & Culture
**Team dynamics**: _____

**Communication style**: _____

**Work pace**: _____

### Action Items for Tomorrow
1. [ ] _____
2. [ ] _____
3. [ ] _____

---

## Monthly Reflection

### End of Month 1
**Date**: _____

**Questions I wish I'd asked earlier**:
1. _____
2. _____
3. _____

**Most helpful answers**:
1. _____
2. _____
3. _____

**Advice for future new hires**:
1. _____
2. _____
3. _____

---

**Last Updated**: December 7, 2025
**Review Before**: First day morning (December 8, 2025)

## Related Documents
- [[plans/ST-Engineering-Learning-Plan]] - 3-month learning roadmap
- [[CLAUDE.md]] - Knowledge base and skills assessment
- Resume: `resume/english-resume.pdf`
- Job Description: `resume/Middle Java Engineer - ST Engineering company.pdf`

## Tags
#onboarding #questions #first-day #career #ST-Engineering #interview 
