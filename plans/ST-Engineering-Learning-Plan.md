# ST Engineering Java Developer - Learning Plan

#career #learning-path #java #spring-boot #devops

**Position**: Mid-Level Java Developer
**Company**: ST Engineering
**Start Date**: December 8, 2025
**Duration**: 3 Months (Dec 2025 - Feb 2026)

---

## Success Rate Assessment

### Overall: 85-90% ✅

#### Strengths (Supporting Success)
- **Technical Skills Match**: 95%
  - ✅ All core requirements covered: Spring Boot, Hibernate/JPA, REST APIs, Microservices, Docker, Maven/Gradle, PostgreSQL/MySQL
  - ✅ All "nice-to-haves" present: RabbitMQ, Angular/React, Azure, CI/CD exposure
  - ✅ Advanced patterns: Hexagonal Architecture, DDD, CQRS, gRPC

- **Real Enterprise Experience**: Axon Active (Swiss insurance company)
  - Contract management for Mobiliar
  - 80% unit test coverage
  - Agile Release Train participation

- **Full-Stack Capability**: Exceeds backend-only requirements
  - React, Angular, Node.js
  - State management (Redux, RxJS)

- **English Proficiency**: 95% (TOEIC 890/990)

- **Self-Learning Ability**: 95%
  - Extensive knowledge base across multiple domains
  - Research-oriented thinking
  - Continuous exploration of new frameworks

#### Risk Factors
- **Experience Gap**: 70%
  - Position requests 2-3 years
  - Actual: ~1.5 years professional (Jul 2024 - Dec 2025)
  - Mitigated by: Complex project experience, strong academic foundation

- **Production Troubleshooting**: Limited documented experience
  - Need to prove: Performance optimization, incident handling, debugging production issues

- **CI/CD Experience**: Azure Pipelines only
  - Gap: Jenkins, GitLab CI (likely what company uses)

- **MongoDB**: Not explicitly listed
  - Only relational database experience documented

---

## Skills Priority Matrix

### P0: CRITICAL (Start Week 1) 🔴

| Skill | Current Level | Target Level | Gap Severity | Time to Close |
|-------|--------------|--------------|--------------|---------------|
| Production Spring Boot | Intermediate | Advanced | Medium | 1 week |
| CI/CD Pipelines (Jenkins) | Beginner | Intermediate | High | 1 week |
| Production Troubleshooting | Beginner | Intermediate | High | 1 week |
| Enterprise Git Workflows | Intermediate | Advanced | Low | 3 days |

**Why Critical**: Daily job requirements, must have from Day 1

---

### P1: HIGH PRIORITY (Month 1) 🟡

| Skill | Current Level | Target Level | Gap Severity | Time to Close |
|-------|--------------|--------------|--------------|---------------|
| Database Performance | Intermediate | Advanced | Medium | 2 weeks |
| Microservices Patterns | Intermediate | Advanced | Medium | 2 weeks |
| Kafka Fundamentals | Beginner | Intermediate | Medium | 1 week |

**Why High**: Essential for independent work and meeting "nice-to-have" requirements

---

### P2: MEDIUM PRIORITY (Month 2-3) 🟢

| Skill | Current Level | Target Level | Gap Severity | Time to Close |
|-------|--------------|--------------|--------------|---------------|
| System Design | Beginner | Intermediate | Medium | 6 weeks |
| Cloud Platform (AWS) | Beginner | Intermediate | Low | 3 weeks |
| Advanced Testing | Intermediate | Advanced | Low | 2 weeks |
| Monitoring & Observability | Beginner | Intermediate | Medium | 2 weeks |

**Why Medium**: Important for growth, contributing to architecture, senior-level progression

---

### P3: LOW PRIORITY (Background) ⚪

| Skill | Current Level | Target Level | Gap Severity | Time to Close |
|-------|--------------|--------------|--------------|---------------|
| MongoDB | Beginner | Beginner+ | Low | 1 week |
| Kubernetes Deep Dive | Intermediate | Advanced | Low | 2 weeks |
| GraphQL | Beginner | Beginner | Very Low | Skip |

**Why Low**: Nice-to-have only, learn if time permits or company uses

---

## 3-Month Learning Roadmap

### Month 1: Foundation & Company Integration

#### Week 1: Onboarding & Production Essentials
**Goal**: Set up environment, understand codebase, deploy first code

**Study Focus**:
- [ ] Production Spring Boot (Actuator, Profiles, Configuration)
- [ ] Enterprise Git Workflows (Rebase, Cherry-pick, Branching strategies)
- [ ] Company codebase exploration

**Deliverables**:
- [ ] Environment fully set up
- [ ] First bug fix merged
- [ ] Architecture map of services created
- [ ] Personal documentation started

**Resources**:
- 📖 "Spring Boot in Action" Ch 1-4, 7-8 (3 days)
- 📖 "Pro Git" Ch 3, 5 (2 days)
- 📝 Spring Boot Reference Documentation (daily reference)

**Time**: 10 hours (2 hrs/day weekdays + 0 hrs weekend - focus on settling in)

---

#### Week 2: CI/CD & Troubleshooting
**Goal**: Deploy code via Jenkins, profile and debug issues

**Study Focus**:
- [ ] Jenkins pipelines (Declarative vs Scripted)
- [ ] VisualVM profiling
- [ ] Logback configuration
- [ ] Production logging best practices

**Deliverables**:
- [ ] First Jenkins deployment completed
- [ ] VisualVM installed and basic profiling done
- [ ] Understand company's logging strategy
- [ ] Create first monitoring dashboard

**Resources**:
- 📺 "Jenkins, From Zero To Hero" (4 hours at 1.5x)
- 🔧 Install Jenkins locally: `docker run -p 8080:8080 jenkins/jenkins:lts`
- 📺 "Java Performance Tuning" by Java Brains (2 hours)
- 📝 Jenkins Pipeline Syntax reference (bookmark)

**Practice Project**:
```groovy
// Create Jenkinsfile for HCMUT HRM project
pipeline {
    agent any
    stages {
        stage('Build') {
            steps { sh './mvnw clean package' }
        }
        stage('Test') {
            steps { sh './mvnw test' }
        }
        stage('Quality') {
            steps { sh './mvnw sonar:sonar' }
        }
        stage('Deploy') {
            steps { sh 'docker build -t myapp .' }
        }
    }
}
```

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

#### Week 3: Database Performance Optimization
**Goal**: Optimize queries, understand indexing strategies

**Study Focus**:
- [ ] EXPLAIN ANALYZE query plans
- [ ] Indexing strategies (B-tree, Hash, Composite)
- [ ] N+1 query problem solutions
- [ ] Connection pooling (HikariCP)

**Deliverables**:
- [ ] Analyze all major queries in HCMUT HRM project
- [ ] Optimize at least 2 slow queries
- [ ] Document optimization findings
- [ ] Present findings to team (if applicable)

**Resources**:
- 📖 "SQL Performance Explained" by Markus Winand (FREE - read entire book, 2 days)
- 📖 "High Performance MySQL" Ch 5-6 (1 week)
- 🔧 Practice: Use EXPLAIN ANALYZE on HCMUT HRM queries

**Practice Exercise**:
```sql
-- Before optimization
EXPLAIN ANALYZE
SELECT u.*, d.name
FROM users u
LEFT JOIN departments d ON u.dept_id = d.id
WHERE u.status = 'active';

-- Check: Sequential scan? Missing index?
-- Add appropriate indexes
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_users_dept_id ON users(dept_id);

-- After optimization
EXPLAIN ANALYZE [same query];
-- Compare: Cost reduction? Index scan?
```

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

#### Week 4: Microservices Communication Patterns
**Goal**: Understand Spring Cloud, API Gateway, Service Discovery

**Study Focus**:
- [ ] Spring Cloud Gateway
- [ ] Eureka Service Discovery
- [ ] Resilience4j Circuit Breaker
- [ ] REST vs gRPC trade-offs (leverage existing knowledge)

**Deliverables**:
- [ ] Build simple microservices demo with Eureka + Gateway
- [ ] Implement circuit breaker pattern
- [ ] Document company's microservices architecture
- [ ] Understand service-to-service communication patterns

**Resources**:
- 📖 "Building Microservices" Ch 4-5 (1 week)
- 📺 "Microservices with Spring Boot and Spring Cloud" (Udemy, 8 hours)
- 📝 Spring Cloud documentation (ongoing reference)

**Practice Project**:
```bash
# Build microservices demo:
1. Eureka Server (Service Registry)
2. API Gateway (Spring Cloud Gateway)
3. User Service (REST API)
4. Order Service (REST API)
5. Circuit Breaker with Resilience4j
```

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

**Month 1 Success Metrics**:
- ✅ Complete first production deployment
- ✅ Resolve first bug independently
- ✅ Optimize at least 1 slow query with measurable improvement
- ✅ Receive positive code review feedback
- ✅ Understand all services in assigned domain
- ✅ Build trust with team members

---

### Month 2: Production Mastery & Advanced Skills

#### Week 5: Kafka Fundamentals
**Goal**: Build Kafka producer/consumer, understand event-driven architecture

**Study Focus**:
- [ ] Kafka architecture (Topics, Partitions, Consumer Groups)
- [ ] Producer/Consumer APIs
- [ ] Kafka vs RabbitMQ comparison
- [ ] Spring Kafka integration

**Deliverables**:
- [ ] Build Kafka producer/consumer demo
- [ ] Understand when to use Kafka vs RabbitMQ
- [ ] Implement event-driven pattern
- [ ] Document findings

**Resources**:
- 📖 "Kafka: The Definitive Guide" Ch 1-4 (4 days)
- 📺 "Apache Kafka for Beginners" by Stephane Maarek (Udemy, 6 hours)
- 🔧 Kafka Docker setup: `docker-compose up -d`
- 📝 Apache Kafka official docs (reference)

**Practice Project**:
```java
// Spring Boot Kafka Integration
@Configuration
public class KafkaConfig {
    @Bean
    public NewTopic orderTopic() {
        return TopicBuilder.name("order-events")
            .partitions(3)
            .replicas(1)
            .build();
    }
}

@Service
public class OrderProducer {
    @Autowired
    private KafkaTemplate<String, OrderEvent> kafkaTemplate;

    public void sendOrder(OrderEvent order) {
        kafkaTemplate.send("order-events", order.getId(), order);
    }
}

@Service
public class OrderConsumer {
    @KafkaListener(topics = "order-events", groupId = "order-processor")
    public void processOrder(OrderEvent order) {
        // Process order
    }
}
```

**Time**: 12 hours (2 hrs/day weekdays + 2 hrs weekend)

---

#### Week 6: System Design Basics
**Goal**: Design common systems, understand trade-offs

**Study Focus**:
- [ ] System design framework (Requirements, Capacity, API, Data Model, Architecture)
- [ ] Common patterns (Load balancing, Caching, Sharding, Replication)
- [ ] CAP theorem understanding
- [ ] Scalability patterns

**Deliverables**:
- [ ] Design URL Shortener system
- [ ] Design Rate Limiter
- [ ] Document design decisions
- [ ] Practice whiteboard design

**Resources**:
- 📖 "System Design Interview" by Alex Xu (entire book, 1 week)
- 📺 Exponent YouTube - System Design videos (10 videos, 10 hours)
- 📝 System Design Primer: https://github.com/donnemartin/system-design-primer

**Practice Routine**:
```
Monday: Read 1 chapter from book
Wednesday: Watch 1 system design video
Friday: Design 1 system on paper
Saturday: Review and refine design
```

**Systems to Design**:
1. URL Shortener (like bit.ly)
2. Rate Limiter (API throttling)
3. News Feed (like Twitter/Facebook)
4. Chat System (like Slack)
5. Notification Service

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

#### Week 7: Monitoring & Observability
**Goal**: Set up Prometheus, Grafana, understand the three pillars

**Study Focus**:
- [ ] Metrics (Prometheus + Grafana)
- [ ] Logs (ELK Stack basics)
- [ ] Traces (Spring Cloud Sleuth)
- [ ] SLIs, SLOs, SLAs

**Deliverables**:
- [ ] Set up Prometheus + Grafana locally
- [ ] Create dashboard for Spring Boot app
- [ ] Configure structured logging
- [ ] Implement distributed tracing

**Resources**:
- 📖 "Distributed Systems Observability" (FREE O'Reilly, 2 days)
- 📺 "Monitoring for Development and DevOps" (LinkedIn Learning, 3 hours)
- 🔧 Docker setup for monitoring stack

**Practice Project**:
```yaml
# docker-compose.yml
version: '3'
services:
  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin

  app:
    image: my-spring-boot-app
    ports:
      - "8080:8080"
```

```java
// Add Micrometer to Spring Boot
@Configuration
public class MetricsConfig {
    @Bean
    public MeterRegistryCustomizer<MeterRegistry> metricsCommonTags() {
        return registry -> registry.config()
            .commonTags("application", "my-app");
    }
}

// Custom metrics
@Service
public class OrderService {
    private final Counter orderCounter;

    public OrderService(MeterRegistry registry) {
        this.orderCounter = registry.counter("orders.created");
    }

    public void createOrder(Order order) {
        // ... business logic
        orderCounter.increment();
    }
}
```

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

#### Week 8: Advanced Testing Strategies
**Goal**: Master integration testing, TestContainers, API testing

**Study Focus**:
- [ ] Testing pyramid (Unit → Integration → E2E)
- [ ] TestContainers for integration tests
- [ ] Rest Assured for API testing
- [ ] Test-Driven Development (TDD) basics

**Deliverables**:
- [ ] Write integration tests with TestContainers
- [ ] API tests with Rest Assured
- [ ] Improve test coverage to 80%+
- [ ] Document testing strategy

**Resources**:
- 📖 "Effective Software Testing" by Mauricio Aniche (1 week)
- 📺 "Testing Spring Boot Applications" (Udemy, 5 hours)
- 📝 JUnit 5, Mockito, Rest Assured documentation

**Practice Examples**:
```java
// Integration Test with TestContainers
@Testcontainers
@SpringBootTest
class UserServiceIntegrationTest {

    @Container
    static PostgreSQLContainer<?> postgres =
        new PostgreSQLContainer<>("postgres:15")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test");

    @DynamicPropertySource
    static void setProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
    }

    @Test
    void shouldCreateUser() {
        // Test with real database
    }
}

// API Test with Rest Assured
@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class UserApiTest {

    @LocalServerPort
    private int port;

    @BeforeEach
    void setUp() {
        RestAssured.port = port;
    }

    @Test
    void shouldGetAllUsers() {
        given()
            .contentType(ContentType.JSON)
        .when()
            .get("/api/users")
        .then()
            .statusCode(200)
            .body("size()", greaterThan(0));
    }
}
```

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

**Month 2 Success Metrics**:
- ✅ Build Kafka-based feature or demo
- ✅ Design 2-3 systems confidently
- ✅ Create monitoring dashboard for your service
- ✅ Write integration tests with TestContainers
- ✅ Optimize 2+ slow endpoints
- ✅ Handle production incidents with minimal help

---

### Month 3: Leadership & Cloud Mastery

#### Week 9: AWS Fundamentals
**Goal**: Deploy Spring Boot app to AWS, understand core services

**Study Focus**:
- [ ] EC2 (Virtual Servers)
- [ ] RDS (Managed Databases)
- [ ] S3 (Object Storage)
- [ ] ECS (Container Service)
- [ ] Lambda (Serverless)
- [ ] CloudWatch (Monitoring)

**Deliverables**:
- [ ] Deploy HCMUT HRM to AWS EC2
- [ ] Set up RDS PostgreSQL
- [ ] Store files in S3
- [ ] Configure CloudWatch monitoring
- [ ] Document AWS architecture

**Resources**:
- 📺 "AWS Certified Developer - Associate" by Stephane Maarek (Udemy, Sections 1-8, 12 hours)
- 📖 "Amazon Web Services in Action" Ch 1-6, 10, 14 (2 weeks)
- 🔧 AWS Free Tier: https://aws.amazon.com/free/
- 📝 AWS Java SDK documentation

**Practice Project**:
```bash
# Deploy Spring Boot App to AWS

## Step 1: EC2 Deployment
1. Launch EC2 instance (t2.micro)
2. Install Java 21, Maven
3. Clone project from Git
4. Build: ./mvnw clean package
5. Run: java -jar target/app.jar
6. Configure Security Group (port 8080)

## Step 2: RDS Setup
1. Create RDS PostgreSQL instance
2. Configure Security Group
3. Update application.properties with RDS endpoint
4. Run migrations

## Step 3: S3 Integration
1. Create S3 bucket
2. Configure AWS SDK
3. Implement file upload/download
4. Set bucket policies

## Step 4: ECS (Container) Deployment
1. Create Docker image
2. Push to ECR (Elastic Container Registry)
3. Create ECS cluster
4. Deploy container
5. Configure load balancer

## Step 5: Monitoring
1. CloudWatch Logs
2. CloudWatch Metrics
3. Set up alarms
4. Create dashboards
```

**Time**: 12 hours (2 hrs/day weekdays + 2 hrs weekend)

---

#### Week 10: System Design Advanced
**Goal**: Design complex, scalable systems

**Study Focus**:
- [ ] Distributed systems fundamentals
- [ ] Data replication and partitioning
- [ ] Consensus algorithms (Paxos, Raft basics)
- [ ] Eventual consistency vs Strong consistency

**Deliverables**:
- [ ] Design News Feed system
- [ ] Design E-commerce platform
- [ ] Design Chat system
- [ ] Document trade-offs for each design

**Resources**:
- 📖 "Designing Data-Intensive Applications" Ch 1-3 (1 week - read slowly)
- 📺 Exponent YouTube - Advanced system design (5 videos)
- 📝 System Design Primer - Advanced topics

**Complex Systems to Design**:
1. **News Feed (Twitter/Facebook)**
   - Fanout on write vs fanout on read
   - Timeline generation
   - Ranking algorithms
   - Scalability to millions of users

2. **E-commerce Platform**
   - Product catalog
   - Inventory management
   - Order processing
   - Payment integration
   - Fraud detection

3. **Chat System (Slack/WhatsApp)**
   - Real-time messaging (WebSocket)
   - Message persistence
   - Group chat
   - Read receipts
   - Push notifications

**Time**: 10 hours (1.5 hrs/day weekdays + 2.5 hrs weekend)

---

#### Week 11: AWS Advanced & Hands-on
**Goal**: Master AWS deployment, CI/CD integration

**Study Focus**:
- [ ] Elastic Beanstalk (PaaS deployment)
- [ ] ECS Fargate (Serverless containers)
- [ ] CodePipeline (CI/CD)
- [ ] CloudFormation (Infrastructure as Code)
- [ ] Auto Scaling and Load Balancing

**Deliverables**:
- [ ] Deploy app to Elastic Beanstalk
- [ ] Set up CodePipeline for auto-deployment
- [ ] Configure Auto Scaling
- [ ] Create CloudFormation template
- [ ] Complete AWS architecture diagram

**Resources**:
- 📺 AWS Certified Developer course - Sections 9-15 (8 hours)
- 🔧 AWS Console hands-on practice
- 📝 AWS Well-Architected Framework documentation

**Practice Project**:
```yaml
# CloudFormation Template Example
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Spring Boot Application Infrastructure'

Resources:
  AppServer:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType: t2.micro
      ImageId: ami-xxxxx
      SecurityGroups:
        - !Ref AppSecurityGroup

  AppDatabase:
    Type: AWS::RDS::DBInstance
    Properties:
      DBInstanceClass: db.t2.micro
      Engine: postgres
      MasterUsername: admin
      MasterUserPassword: !Ref DBPassword

  AppLoadBalancer:
    Type: AWS::ElasticLoadBalancingV2::LoadBalancer
    Properties:
      Scheme: internet-facing
      Subnets:
        - !Ref PublicSubnet1
        - !Ref PublicSubnet2
```

**Time**: 12 hours (2 hrs/day weekdays + 2 hrs weekend)

---

#### Week 12: MongoDB & Consolidation
**Goal**: Learn MongoDB basics, review all P0-P2 topics

**Study Focus**:
- [ ] MongoDB CRUD operations
- [ ] Aggregation pipeline
- [ ] Indexing in MongoDB
- [ ] When to use MongoDB vs PostgreSQL
- [ ] Review Week: Revisit P0-P1 topics

**Deliverables**:
- [ ] Build simple MongoDB CRUD app
- [ ] Compare with relational approach
- [ ] Complete knowledge gaps review
- [ ] Update resume with new skills
- [ ] Prepare for performance review

**Resources**:
- 📺 "MongoDB - The Complete Developer's Guide" (Udemy, Sections 1-5, 4 hours)
- 📝 MongoDB Manual: https://docs.mongodb.com/manual/
- 🔧 MongoDB Docker: `docker run -d -p 27017:27017 mongo`

**MongoDB Basics**:
```javascript
// CRUD Operations
db.users.insertOne({
    name: "John Doe",
    email: "john@example.com",
    age: 30,
    skills: ["Java", "Spring Boot", "AWS"]
});

db.users.find({ age: { $gte: 25 } });

db.users.updateOne(
    { email: "john@example.com" },
    { $set: { age: 31 } }
);

// Aggregation Pipeline
db.orders.aggregate([
    { $match: { status: "completed" } },
    { $group: {
        _id: "$customerId",
        totalAmount: { $sum: "$amount" }
    }},
    { $sort: { totalAmount: -1 } },
    { $limit: 10 }
]);

// Indexing
db.users.createIndex({ email: 1 }, { unique: true });
db.orders.createIndex({ customerId: 1, createdAt: -1 });
```

**Review Checklist**:
- [ ] P0: Production Spring Boot - Can I deploy with confidence? ✅
- [ ] P0: CI/CD - Can I create Jenkins pipelines? ✅
- [ ] P0: Troubleshooting - Can I debug production issues? ✅
- [ ] P1: Database Optimization - Can I optimize slow queries? ✅
- [ ] P1: Microservices - Do I understand service patterns? ✅
- [ ] P1: Kafka - Can I build event-driven systems? ✅
- [ ] P2: System Design - Can I design scalable systems? ✅
- [ ] P2: AWS - Can I deploy to cloud? ✅
- [ ] P2: Testing - Can I write comprehensive tests? ✅
- [ ] P2: Monitoring - Can I set up observability? ✅

**Time**: 8 hours (1 hr/day weekdays + 3 hrs weekend - lighter week)

---

**Month 3 Success Metrics**:
- ✅ Deploy Spring Boot app to AWS (EC2, ECS, or Elastic Beanstalk)
- ✅ Design 3 complex systems (News feed, Chat, E-commerce)
- ✅ Lead 1 feature end-to-end
- ✅ Present 1 technical topic to team
- ✅ Mentor junior developer on at least 1 task
- ✅ Receive "exceeds expectations" in 3-month review

---

## Learning Resources Library

### Essential Books (Must Buy - ~$150)

#### Priority 1: Buy Immediately
1. 📕 **"Spring Boot in Action"** by Craig Walls - $40
   - Daily reference for Spring Boot development
   - Focus: Ch 1-4 (basics), 7 (Actuator), 8 (Deployment)
   - **Start**: Week 1

2. 📗 **"Kafka: The Definitive Guide"** by Neha Narkhede - $50
   - Essential for event-driven architecture
   - Focus: Ch 1-4 initially, full book later
   - **Start**: Week 5

3. 📘 **"Designing Data-Intensive Applications"** by Martin Kleppmann - $45
   - The bible for system design and distributed systems
   - Focus: Ch 1-3 (foundations), 5-7 (replication, partitioning, transactions)
   - **Start**: Week 10

4. 📙 **"System Design Interview"** Vol 1 by Alex Xu - $35
   - Practical system design patterns
   - Focus: Entire book, very practical
   - **Start**: Week 6

#### Priority 2: Buy Later (Month 2-3)
5. 📓 "High Performance MySQL" by Baron Schwartz - $50
6. 📔 "Building Microservices" by Sam Newman (2nd Ed) - $45
7. 📒 "Amazon Web Services in Action" by Andreas Wittig - $40

#### Free Books (Download Immediately)
- ✅ **"Pro Git"** by Scott Chacon - https://git-scm.com/book/en/v2
- ✅ **"SQL Performance Explained"** by Markus Winand - https://sql-performance-explained.com/
- ✅ **"Distributed Systems Observability"** by Cindy Sridharan - O'Reilly FREE
- ✅ **Spring Boot Reference Documentation** - https://docs.spring.io/spring-boot/

---

### Online Courses (Budget: ~$100)

**When to Buy**: Wait for Udemy sales ($10-15 each, happen monthly)

#### Must-Have Courses
1. 🎬 **"AWS Certified Developer - Associate"** by Stephane Maarek
   - Platform: Udemy
   - Duration: 28 hours
   - Focus: Sections 1-8 (EC2, RDS, S3, Lambda, ECS, CloudWatch)
   - **Start**: Week 9
   - Regular Price: $89.99 | Sale Price: $12.99

2. 🎬 **"Apache Kafka for Beginners"** by Stephane Maarek
   - Platform: Udemy
   - Duration: 9 hours
   - **Start**: Week 5
   - Regular Price: $84.99 | Sale Price: $11.99

3. 🎬 **"Microservices with Spring Boot and Spring Cloud"** by Ranga Karanam
   - Platform: Udemy
   - Duration: 22 hours
   - Focus: Sections on Eureka, API Gateway, Circuit Breaker
   - **Start**: Week 4
   - Regular Price: $84.99 | Sale Price: $11.99

4. 🎬 **"Testing Spring Boot Applications"** by Philip Riecks
   - Platform: Udemy
   - Duration: 5 hours
   - **Start**: Week 8
   - Regular Price: $69.99 | Sale Price: $11.99

#### Free Courses
- ✅ **"Jenkins, From Zero To Hero"** by DevOps Academy (YouTube)
  - https://www.youtube.com/watch?v=6YZvp2GwT0A
  - Duration: 4 hours
  - **Start**: Week 2

- ✅ **"Java Performance Tuning"** by Java Brains (YouTube)
  - https://www.youtube.com/watch?v=2KKx5pSIqKI
  - Duration: 2 hours
  - **Start**: Week 2

---

### Documentation Sites (Bookmark These)

#### Daily Reference
1. 📚 **Spring Ecosystem** - https://spring.io/docs
   - Spring Boot Reference
   - Spring Data JPA
   - Spring Cloud
   - Spring Security

2. 📚 **Apache Kafka** - https://kafka.apache.org/documentation/
   - Producer API
   - Consumer API
   - Streams API

3. 📚 **Jenkins** - https://www.jenkins.io/doc/
   - Pipeline Syntax
   - Plugin Documentation
   - Best Practices

4. 📚 **AWS Documentation** - https://docs.aws.amazon.com/
   - EC2 User Guide
   - RDS Database Guide
   - ECS Developer Guide
   - CloudWatch Logs

5. 📚 **System Design Primer** - https://github.com/donnemartin/system-design-primer
   - Comprehensive guide
   - Practice problems
   - Real-world architectures

#### Additional References
- 📚 PostgreSQL Documentation - https://www.postgresql.org/docs/
- 📚 Docker Documentation - https://docs.docker.com/
- 📚 Git Documentation - https://git-scm.com/doc
- 📚 Hibernate ORM - https://hibernate.org/orm/documentation/

---

### YouTube Channels

#### Primary Channels (Subscribe)
1. 📺 **Amigoscode** - Java, Spring Boot, Microservices
   - Modern Java tutorials
   - Spring Boot best practices
   - Microservices patterns

2. 📺 **Java Brains** - Deep Java concepts
   - Spring framework internals
   - Design patterns
   - Performance tuning

3. 📺 **Exponent** - System Design
   - Mock interviews
   - System design walkthroughs
   - Tech interview prep

4. 📺 **TechWorld with Nana** - DevOps
   - Docker tutorials
   - Kubernetes
   - CI/CD pipelines

5. 📺 **Hussein Nasser** - Backend Engineering
   - Database internals
   - Network protocols
   - System architecture

#### Supplementary Channels
- 📺 Dan Vega - Spring Boot updates
- 📺 Defog Tech - System design interviews
- 📺 ByteByteGo - System design visuals
- 📺 CodeOpinion - Software architecture

---

### Tools & Software

#### Development Tools
```bash
# Essential Tools (Install Week 1)
- IntelliJ IDEA Ultimate (company license)
- Docker Desktop
- Postman / Insomnia
- DBeaver (Database client)
- Visual Studio Code (for quick edits)

# Performance Tools (Install Week 2)
- VisualVM (FREE Java profiler)
- JProfiler (Trial, then company license)
- JMeter (Load testing)

# Monitoring Tools (Install Week 7)
- Prometheus (Docker)
- Grafana (Docker)
- Elasticsearch + Kibana (Docker)

# Cloud Tools (Install Week 9)
- AWS CLI
- AWS SDK for Java
- Terraform (Infrastructure as Code)
```

#### Docker Compose Stacks
```yaml
# monitoring-stack.yml
version: '3.8'
services:
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin

# kafka-stack.yml
version: '3.8'
services:
  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181

  kafka:
    image: confluentinc/cp-kafka:latest
    ports:
      - "9092:9092"
    environment:
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092

# elk-stack.yml
version: '3.8'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.11.0
    ports:
      - "9200:9200"

  kibana:
    image: docker.elastic.co/kibana/kibana:8.11.0
    ports:
      - "5601:5601"
```

---

## Weekly Study Routine

### Weekday Schedule (Monday - Friday)

#### Morning (Before Work)
- **8:00 - 8:30 AM**: Review previous day's learnings
  - Read personal notes
  - Review code written yesterday
  - Plan today's focus

#### Lunch Break
- **12:00 - 12:30 PM**: Light learning (30 mins)
  - 15 mins: Read documentation
  - 15 mins: Quick coding exercise

#### Evening (After Work)
- **5:30 - 7:00 PM**: Focused study session (1.5 hours)
  - **5:30 - 6:00 PM**: Theory (30 mins)
    - Read book chapter OR watch course video
    - Take notes in Obsidian

  - **6:00 - 6:45 PM**: Hands-on practice (45 mins)
    - Code examples
    - Build small demos
    - Practice exercises

  - **6:45 - 7:00 PM**: Documentation (15 mins)
    - Update learning log
    - Document key insights
    - Prepare questions for team

**Daily Total**: 2 hours

---

### Weekend Schedule

#### Saturday - Deep Work
- **9:00 AM - 1:00 PM**: Project-based learning (4 hours)
  - **9:00 - 10:30 AM**: Build practice project
    - Week 2: Jenkins pipeline for HCMUT HRM
    - Week 3: Database optimization project
    - Week 4: Microservices demo
    - Week 5: Kafka producer/consumer
    - Week 6: System design practice
    - Week 7: Monitoring stack setup
    - Week 8: Integration testing suite
    - Week 9: AWS deployment
    - Week 10: Complex system design
    - Week 11: CloudFormation templates
    - Week 12: MongoDB CRUD app

  - **10:30 - 11:00 AM**: Break

  - **11:00 AM - 1:00 PM**: Continue project
    - Complete implementation
    - Document learnings
    - Commit to Git

#### Sunday - Review & Consolidation
- **2:00 - 5:00 PM**: Weekly review (3 hours)
  - **2:00 - 3:00 PM**: Review week's material
    - Re-read notes
    - Review code written
    - Identify gaps

  - **3:00 - 3:15 PM**: Break

  - **3:15 - 4:15 PM**: Update knowledge base
    - Add notes to Obsidian
    - Create diagrams
    - Link related concepts

  - **4:15 - 5:00 PM**: Prepare for next week
    - Review next week's topics
    - Download resources
    - Set weekly goals
    - Prepare questions for team

**Weekend Total**: 7 hours

---

### Weekly Time Commitment

| Period | Hours | Focus |
|--------|-------|-------|
| Monday - Friday | 10 hrs | Theory + Practice (2 hrs/day) |
| Saturday | 4 hrs | Project-based learning |
| Sunday | 3 hrs | Review + Consolidation |
| **Total** | **17 hrs/week** | |

**Note**: First month may be lighter (10-12 hrs/week) due to onboarding workload

---

## Progress Tracking

### Monthly Checklists

#### End of Month 1 ✅
**Technical Achievements**:
- [ ] Can deploy code independently via CI/CD
- [ ] Created and merged 5+ pull requests
- [ ] Optimized at least 1 slow query (>50% improvement)
- [ ] Understand all services in assigned domain
- [ ] Set up proper logging for assigned services
- [ ] Can read and interpret production logs

**Behavioral Achievements**:
- [ ] Received positive code review feedback
- [ ] Attended all team ceremonies
- [ ] Asked clarifying questions actively
- [ ] Built relationships with 3+ team members
- [ ] Completed first on-call shift (shadow)

**Learning Achievements**:
- [ ] Completed "Spring Boot in Action" Ch 1-4, 7-8
- [ ] Completed Jenkins course
- [ ] Read "SQL Performance Explained"
- [ ] Built microservices demo with Eureka + Gateway
- [ ] Updated Obsidian knowledge base with new learnings

---

#### End of Month 2 ✅
**Technical Achievements**:
- [ ] Built Kafka-based feature or demo
- [ ] Designed 2-3 systems confidently
- [ ] Created Grafana dashboard for your service
- [ ] Wrote integration tests with TestContainers
- [ ] Optimized 2+ slow endpoints
- [ ] Handled production incident with minimal help
- [ ] Completed medium-sized feature independently

**Behavioral Achievements**:
- [ ] Led daily standup or sprint retrospective
- [ ] Provided meaningful code review feedback
- [ ] Contributed to technical discussion/decision
- [ ] Helped onboard new team member
- [ ] Presented learning to team (brown bag session)

**Learning Achievements**:
- [ ] Completed "Kafka: The Definitive Guide" Ch 1-4
- [ ] Read "System Design Interview" (Alex Xu)
- [ ] Set up complete monitoring stack
- [ ] Achieved 80%+ test coverage on assigned services
- [ ] Completed 5+ system design practice problems

---

#### End of Month 3 ✅
**Technical Achievements**:
- [ ] Deployed Spring Boot app to AWS
- [ ] Designed 3 complex systems (News feed level)
- [ ] Led feature from design to deployment
- [ ] Configured Auto Scaling and Load Balancing
- [ ] Created CloudFormation template
- [ ] Implemented circuit breaker pattern
- [ ] Optimized 5+ slow endpoints total

**Behavioral Achievements**:
- [ ] Presented technical topic to entire team
- [ ] Mentored junior developer
- [ ] Led sprint planning or grooming session
- [ ] Proposed architectural improvement (with data)
- [ ] Received "exceeds expectations" in review
- [ ] On-call independently without escalations

**Learning Achievements**:
- [ ] Completed AWS Developer course
- [ ] Read "Designing Data-Intensive Applications" Ch 1-7
- [ ] Deployed 3 different projects to AWS
- [ ] Can design and defend system architecture
- [ ] Updated resume with new skills and achievements
- [ ] Comprehensive Obsidian knowledge base

---

### Weekly Learning Log Template

Create in Obsidian: `plans/weekly-logs/Week-{number}.md`

```markdown
# Week {number} Learning Log
**Date**: {start-date} to {end-date}
**Focus**: {main topics this week}

## Completed ✅
- [x] Task 1
- [x] Task 2
- [x] Task 3

## In Progress 🔄
- [ ] Task A (50% complete)
- [ ] Task B (30% complete)

## Blocked 🚧
- Issue 1: {description}
- Issue 2: {description}

## This Week's Learnings 📚

### Technical
- **Spring Boot**: Learned about {topic}
- **Database**: Optimized query from {before}ms to {after}ms
- **DevOps**: Set up {tool/service}

### Behavioral
- Participated in {meeting/discussion}
- Helped {teammate} with {issue}
- Learned about {business context}

## Questions for Team ❓
1. Which {technology A} vs {technology B} do we prefer?
2. How do we handle {specific scenario}?
3. Can I get access to {system/tool}?

## This Week's Win 🎉
{Biggest achievement or learning}

## Next Week Focus 🎯
- [ ] Goal 1
- [ ] Goal 2
- [ ] Goal 3

## Time Spent
- Study: {hours} hours
- Practice: {hours} hours
- Total: {hours} hours

## Resources Used
- 📖 {book} - Ch {chapters}
- 📺 {course} - {sections}
- 🔧 {tool/project}
```

---

## Critical Success Factors

### Do's ✅

1. **Over-communicate**
   - Share progress daily in standup
   - Update Jira tickets frequently
   - Ask questions publicly in team channels
   - Document decisions and learnings

2. **Ask "Why" not just "How"**
   - Understand business context
   - Learn domain knowledge
   - Connect technical decisions to business value
   - Think from user/customer perspective

3. **Build relationships**
   - Schedule 1-on-1s with team members
   - Pair program with senior developers
   - Collaborate with DevOps, QA, frontend teams
   - Attend team social events

4. **Show initiative**
   - Volunteer for challenging tasks
   - Propose improvements (with data)
   - Help teammates proactively
   - Contribute to documentation

5. **Focus on business impact**
   - Frame work in business value terms
   - "This optimization saves $X in infrastructure costs"
   - "This feature increases user retention by Y%"
   - Understand ROI of technical decisions

6. **Maintain quality**
   - Write tests first (TDD when possible)
   - Keep 80%+ coverage
   - Follow coding standards religiously
   - Review your own PRs before submitting

---

### Don'ts ❌

1. **Don't hide struggles**
   - Ask for help when blocked (within 2 hours)
   - Share if falling behind on deadlines
   - Admit when you don't know something
   - Request pair programming when stuck

2. **Don't skip testing**
   - Never commit untested code
   - Maintain your 80% coverage standard
   - Write tests before fixing bugs
   - Add integration tests for critical flows

3. **Don't over-engineer**
   - Match company's complexity level
   - YAGNI (You Aren't Gonna Need It)
   - Refactor only when necessary
   - Keep it simple and readable

4. **Don't work in isolation**
   - Collaborate actively
   - Share work-in-progress early
   - Get feedback frequently
   - Pair program regularly

5. **Don't ignore soft skills**
   - Communication > Code quality
   - Explain technical decisions clearly
   - Write clear PR descriptions
   - Document for future developers

6. **Don't compare with senior devs**
   - Focus on your growth trajectory
   - Learn from seniors, don't compete
   - Celebrate small wins
   - Be patient with learning curve

---

## Risk Mitigation Strategies

### Risk 1: Experience Gap (2-3 years vs 1.5 years)
**Mitigation**:
- ✅ Demonstrate maturity through code quality and testing
- ✅ Show depth over breadth in technical discussions
- ✅ Highlight complex projects (Gluon insurance system)
- ✅ Learn quickly and visibly document growth
- ✅ Take on challenging tasks proactively

**Month 1 Goal**: Prove you can deliver independently
**Month 2 Goal**: Prove you can handle production issues
**Month 3 Goal**: Prove you can lead and mentor

---

### Risk 2: Jenkins/GitLab CI Gap
**Mitigation**:
- ✅ Week 2 priority: Jenkins course + hands-on
- ✅ Ask for Jenkins access immediately
- ✅ Study company's existing pipelines
- ✅ Volunteer to improve CI/CD processes
- ✅ Leverage existing Azure Pipelines knowledge

**Target**: Create first Jenkins pipeline by Week 2

---

### Risk 3: Production Troubleshooting Experience
**Mitigation**:
- ✅ Shadow on-call senior developer Month 1
- ✅ Learn monitoring tools (Prometheus/Grafana) Week 7
- ✅ Practice profiling with VisualVM Week 2
- ✅ Volunteer for bug fix tickets
- ✅ Document every incident response

**Target**: Handle first incident independently by Month 2

---

### Risk 4: System Design Interview Skills
**Mitigation**:
- ✅ Read "System Design Interview" Week 6
- ✅ Practice 1 design per week
- ✅ Participate actively in architecture discussions
- ✅ Document design decisions (ADRs)
- ✅ Study company's existing architecture

**Target**: Lead 1 design discussion by Month 3

---

## First Week Preparation Checklist

### This Weekend (Before Monday Start)

#### Technical Setup (4 hours)
- [ ] Install VisualVM: https://visualvm.github.io/download.html
- [ ] Install Docker Desktop (if not already)
- [ ] Set up local Jenkins:
  ```bash
  docker run -d -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
  ```
- [ ] Install DBeaver (database client)
- [ ] Install Postman or Insomnia
- [ ] Clone HCMUT HRM project for practice
- [ ] Update Git configuration:
  ```bash
  git config --global user.name "Khoa Ngo"
  git config --global user.email "ngokhoa1202@gmail.com"
  ```

#### Learning Resources Setup (1 hour)
- [ ] Buy "Spring Boot in Action" (ebook for instant access)
- [ ] Download "Pro Git" PDF
- [ ] Bookmark Spring Boot documentation
- [ ] Enroll in Jenkins YouTube course
- [ ] Create Udemy account (wait for sale for paid courses)
- [ ] Subscribe to recommended YouTube channels

#### Documentation Setup (1 hour)
- [ ] Create Obsidian daily note template
- [ ] Create `plans/weekly-logs/` folder
- [ ] Set up Week 1 learning log
- [ ] Create `work/ST-Engineering/` folder for work notes
- [ ] Prepare questions list for onboarding

#### Mental Preparation (30 mins)
- [ ] Review job description again
- [ ] Review your resume accomplishments
- [ ] Prepare 30-second self-introduction
- [ ] List your strengths and areas for growth
- [ ] Set personal goals for 3 months

---

### Monday (First Day)

#### Morning
- [ ] Arrive early (or log in early if remote)
- [ ] Bring notebook and pen
- [ ] Have questions list ready
- [ ] Dress appropriately (business casual)

#### Key Questions to Ask
**About Tech Stack**:
- What monitoring tools do we use? (Prometheus, ELK, etc.)
- Jenkins or GitLab CI for CI/CD?
- Do we use Kafka or RabbitMQ?
- Which cloud platform? (AWS, Azure, GCP)
- Kubernetes or just Docker?

**About Team**:
- Who is my mentor/buddy?
- Who should I ask for what? (architecture, devops, etc.)
- What's our sprint schedule?
- When are daily standups?

**About Work**:
- What's my first task?
- How do I access {Jenkins, databases, AWS, etc.}?
- What's the code review process?
- What's the deployment process?

#### After Work
- [ ] Review company documentation
- [ ] Set up all access (VPN, Git, Jira, etc.)
- [ ] Start "Spring Boot in Action" Ch 1-2
- [ ] Create first daily note
- [ ] Reflect on first day

---

## Measurement & Tracking

### Key Performance Indicators (KPIs)

#### Month 1 KPIs
| Metric | Target | Actual |
|--------|--------|--------|
| PRs merged | 5+ | |
| Code review feedback rating | 4+/5 | |
| Query optimization wins | 1+ | |
| Study hours/week | 10+ | |
| On-time task completion | 90%+ | |

#### Month 2 KPIs
| Metric | Target | Actual |
|--------|--------|--------|
| Features completed independently | 2+ | |
| Production incidents handled | 2+ | |
| System designs practiced | 8+ | |
| Test coverage on new code | 80%+ | |
| Study hours/week | 10+ | |

#### Month 3 KPIs
| Metric | Target | Actual |
|--------|--------|--------|
| Features led end-to-end | 1+ | |
| Technical presentations | 1+ | |
| Junior developers mentored | 1+ | |
| AWS deployments | 3+ | |
| Study hours/week | 10+ | |

---

### Skills Progression Tracker

Track in Obsidian: `plans/skills-tracker.md`

```markdown
# Skills Progression Tracker

## P0 Critical Skills

### Production Spring Boot
- [x] Basic (Week 0) - Can build Spring Boot apps
- [ ] Intermediate (Week 1) - Actuator, Profiles, Configuration
- [ ] Advanced (Month 2) - Custom starters, Auto-configuration
- [ ] Expert (Month 4+) - Performance tuning, Internals

### CI/CD (Jenkins)
- [ ] Beginner (Week 0) - Basic pipeline concept
- [ ] Intermediate (Week 2) - Create declarative pipelines
- [ ] Advanced (Month 2) - Shared libraries, Complex workflows
- [ ] Expert (Month 4+) - Jenkins administration

### Production Troubleshooting
- [ ] Beginner (Week 0) - Basic debugging
- [ ] Intermediate (Week 3) - Profiling, Log analysis
- [ ] Advanced (Month 3) - Root cause analysis, Incident response
- [ ] Expert (Month 6+) - Performance engineering

## P1 High Priority Skills

### Kafka
- [ ] Beginner (Week 0) - Basic concepts
- [ ] Intermediate (Week 5) - Producer/Consumer APIs
- [ ] Advanced (Month 3) - Streams API, Exactly-once semantics
- [ ] Expert (Month 6+) - Kafka administration

### System Design
- [ ] Beginner (Week 0) - Basic patterns
- [ ] Intermediate (Week 6) - Common systems (URL shortener)
- [ ] Advanced (Week 10) - Complex systems (News feed)
- [ ] Expert (Month 6+) - Large-scale distributed systems

## P2 Medium Priority Skills

### AWS
- [ ] Beginner (Week 0) - Basic concepts
- [ ] Intermediate (Week 9) - EC2, RDS, S3
- [ ] Advanced (Week 11) - ECS, Lambda, CloudFormation
- [ ] Expert (Month 6+) - Well-Architected Framework
```

---

## Conclusion

### Success Formula

```
Success = (Technical Skills × Learning Agility) + (Communication × Collaboration) + (Business Impact × Initiative)
```

**Your Current Profile**:
- ✅ Strong technical foundation (85/100)
- ✅ Excellent learning agility (95/100)
- ✅ Good communication (English 890 TOEIC)
- 🔄 Collaboration (prove in first month)
- 🔄 Business impact (demonstrate with metrics)
- 🔄 Initiative (show proactively)

**Expected Growth Trajectory**:
- **Month 1**: Prove you can deliver → Mid-level baseline
- **Month 2**: Prove you can handle complexity → Strong mid-level
- **Month 3**: Prove you can lead → Senior-track

---

### Final Reminders

1. **You were hired for a reason** - You passed their interview, they believe in you

2. **Everyone has imposter syndrome** - Especially in first 3 months, it's normal

3. **Ask questions** - No one expects you to know everything on Day 1

4. **Focus on learning, not perfection** - Growth mindset over ego

5. **Build relationships** - Technical skills get you hired, relationships keep you thriving

6. **Document everything** - Your future self will thank you

7. **Celebrate small wins** - Progress compounds

8. **Be patient** - Expertise takes time, focus on consistent daily improvement

9. **Your comprehensive knowledge base is your superpower** - Use it

10. **You've got this!** 🚀

---

**Last Updated**: December 7, 2025
**Review Schedule**: Weekly on Sundays
**Next Review**: December 14, 2025

---

## Quick Links

- [[CLAUDE.md]] - Repository overview and knowledge assessment
- [[plans/08-07-2025]] - Earlier planning notes
- [[projects/leave-management/Business]] - HCMUT HRM project
- Resume: `resume/english-resume.pdf`
- Job Description: `resume/Middle Java Engineer - ST Engineering company.pdf`

## Tags
#career #learning-path #java #spring-boot #microservices #kafka #aws #system-design #devops #jenkins #performance-optimization #ST-Engineering
