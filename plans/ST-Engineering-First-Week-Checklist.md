# First Week Checklist - ST Engineering

#career #onboarding #checklist #ST-Engineering

**Position**: Mid-Level Java Developer
**Start Date**: December 8, 2025
**Week**: Week 1 (Dec 8-14, 2025)

---

## Pre-Day 1 Preparation (Complete This Weekend)

### Technical Setup ✅
- [ ] Install IntelliJ IDEA Ultimate (trial if no license yet)
- [ ] Install Docker Desktop
- [ ] Install VisualVM for Java profiling
- [ ] Install DBeaver (universal database client)
- [ ] Install Postman or Insomnia (API testing)
- [ ] Update Git to latest version
- [ ] Configure Git globally:
  ```bash
  git config --global user.name "Khoa Ngo"
  git config --global user.email "ngokhoa1202@gmail.com"
  git config --global core.editor "vim"  # or your preferred editor
  ```
- [ ] Install local Jenkins (Docker):
  ```bash
  docker run -d -p 8080:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts
  ```

### Learning Resources ✅
- [ ] Purchase "Spring Boot in Action" (ebook for immediate access)
- [ ] Download "Pro Git" PDF from https://git-scm.com/book/en/v2
- [ ] Bookmark Spring Boot documentation: https://docs.spring.io/spring-boot/
- [ ] Enroll in "Jenkins From Zero to Hero" (YouTube - FREE)
- [ ] Subscribe to YouTube channels: Amigoscode, Java Brains, TechWorld with Nana
- [ ] Create Udemy account (for future course purchases)

### Documentation Setup ✅
- [ ] Create Obsidian folder structure:
  ```
  work/
    ST-Engineering/
      daily-notes/
      meetings/
      projects/
      learnings/
  ```
- [ ] Set up daily note template in Obsidian
- [ ] Create Week 1 learning log: `plans/weekly-logs/Week-01.md`
- [ ] Print or have digital copy of question list ready

### Mental Preparation ✅
- [ ] Review job description one more time
- [ ] Review your resume accomplishments
- [ ] Prepare 30-second self-introduction:
  ```
  "Hi, I'm Khoa. I'm a computer science graduate from HCMUT with about
  1.5 years of experience in Java development. Most recently, I worked
  at Axon Active on a Swiss insurance system using Quarkus and
  microservices. I also have full-stack experience with React and
  Node.js. I'm excited to join the team and learn from everyone!"
  ```
- [ ] List your strengths: Java/Spring Boot, Microservices, Testing, Full-stack
- [ ] Identify areas to learn: Jenkins CI/CD, AWS, Production troubleshooting
- [ ] Get good sleep! 😴

---

## Day 1: Monday, December 8, 2025

### Morning (8:00 AM - 12:00 PM)

#### First Hour (8:00-9:00 AM)
- [ ] Arrive 15 minutes early (or log in early if remote)
- [ ] Bring:
  - [ ] Notebook and pen
  - [ ] Laptop (if not provided)
  - [ ] Question list (printed or digital)
  - [ ] ID documents
  - [ ] Positive attitude! 😊

- [ ] Meet HR and complete paperwork:
  - [ ] Employment contracts
  - [ ] Tax forms
  - [ ] Benefits enrollment
  - [ ] Company policies acknowledgment

#### Workspace Setup (9:00-10:00 AM)
- [ ] Get assigned workspace (desk, chair, monitor)
- [ ] Receive work laptop/equipment
- [ ] Set up email account
- [ ] Set up VPN (if applicable)
- [ ] Join communication platforms:
  - [ ] Slack/Teams workspace
  - [ ] Email distribution lists
  - [ ] Company intranet access

#### Team Introductions (10:00-11:00 AM)
- [ ] Meet direct manager/team lead
  - [ ] Get manager's contact info
  - [ ] Schedule first 1-on-1
  - [ ] Understand reporting structure

- [ ] Meet onboarding buddy/mentor
  - [ ] Get buddy's contact info
  - [ ] Schedule daily check-ins for first week
  - [ ] Ask about team norms and culture

- [ ] Team introductions (standup or dedicated meeting)
  - [ ] Note everyone's names and roles
  - [ ] Understand team structure
  - [ ] Learn about ongoing projects

#### Initial Setup (11:00 AM-12:00 PM)
- [ ] Request access to systems (ask IT/buddy):
  - [ ] Git repository (GitHub/GitLab/Bitbucket)
  - [ ] Jira/Project management tool
  - [ ] Confluence/Documentation platform
  - [ ] Jenkins/CI-CD system
  - [ ] Database access (dev environment)
  - [ ] Cloud platform (AWS/Azure console)
  - [ ] Monitoring tools
  - [ ] Code repository

- [ ] Get onboarding documentation links
- [ ] Review company org chart

**Critical Questions to Ask (Morning)**:
- ✅ Q1.5: How do I access Git repository?
- ✅ Q3.1: What access do I need to request?
- ✅ Q4.1: Who is my direct manager?
- ✅ Q4.2: Who is my onboarding buddy?
- ✅ Q4.3: Meeting schedule?

---

### Lunch (12:00-1:00 PM)
- [ ] Lunch with team (if invited) or buddy
- [ ] Learn about:
  - [ ] Team lunch culture
  - [ ] Nearby food options
  - [ ] Lunch break norms
  - [ ] Informal team dynamics

**Pro Tips**:
- ✅ Be friendly and open
- ✅ Ask about people's backgrounds
- ✅ Listen more than talk
- ❌ Don't talk about politics, religion, or controversial topics
- ❌ Don't complain about previous employer

---

### Afternoon (1:00-5:00 PM)

#### Development Environment Setup (1:00-3:00 PM)
- [ ] Install required software (from IT or buddy):
  - [ ] IntelliJ IDEA (company license)
  - [ ] Git client
  - [ ] Database client
  - [ ] Docker Desktop
  - [ ] VPN client
  - [ ] Communication tools
  - [ ] Any company-specific tools

- [ ] Clone main repository:
  ```bash
  # Get repo URL from buddy
  git clone <repo-url>
  cd <project-name>
  ```

- [ ] Set up development environment:
  - [ ] Install Java (correct version)
  - [ ] Install Maven/Gradle
  - [ ] Configure IDE settings
  - [ ] Import code style configurations
  - [ ] Install required IDE plugins

- [ ] Build project locally:
  ```bash
  # Maven
  ./mvnw clean install

  # Gradle
  ./gradlew build
  ```
  - [ ] Troubleshoot build errors with buddy
  - [ ] Verify tests pass locally

- [ ] Run application locally:
  ```bash
  # Spring Boot typical command
  ./mvnw spring-boot:run

  # Or
  java -jar target/application.jar
  ```
  - [ ] Verify app starts successfully
  - [ ] Access app in browser (http://localhost:8080 or specified port)
  - [ ] Test basic endpoints with Postman

**Critical Questions to Ask (Afternoon Setup)**:
- ✅ Q1.1: What IDE and version?
- ✅ Q1.2: Java version?
- ✅ Q1.3: Maven or Gradle?
- ✅ Q1.8: Database access for dev?
- ✅ Q1.9: Local database setup?

#### Project Overview (3:00-4:00 PM)
- [ ] Review project README
- [ ] Understand project structure:
  - [ ] Main application modules
  - [ ] Configuration locations
  - [ ] Test structure
  - [ ] Build scripts

- [ ] Review architecture documentation:
  - [ ] System architecture diagrams
  - [ ] Microservices overview (if applicable)
  - [ ] Database schema
  - [ ] API documentation

- [ ] Identify your team's service/module:
  - [ ] What does it do?
  - [ ] Who are the users?
  - [ ] Key dependencies
  - [ ] Related services

**Critical Questions to Ask**:
- ✅ Q7.1: Spring stack details?
- ✅ Q7.2: Microservices architecture?
- ✅ Q6.4: Where is documentation?

#### First Task Assignment (4:00-5:00 PM)
- [ ] Get first task/ticket from manager or buddy
  - [ ] Task description: _____
  - [ ] Jira ticket number: _____
  - [ ] Expected timeline: _____
  - [ ] Who to ask for help: _____

- [ ] Understand task requirements:
  - [ ] Acceptance criteria
  - [ ] Related code locations
  - [ ] Required changes
  - [ ] Testing requirements

- [ ] Create feature branch:
  ```bash
  # Follow team's naming convention
  git checkout -b feature/TICKET-123-description
  ```

**Critical Questions to Ask**:
- ✅ Q5.1: What's my first task?
- ✅ Q5.2: First week expectations?
- ✅ Q1.6: Branching strategy?

---

### End of Day (5:00-5:30 PM)
- [ ] Review what was accomplished today
- [ ] Create task list for tomorrow
- [ ] Update question tracking
- [ ] Send thank you message to buddy/mentor
- [ ] Fill out Day 1 reflection (below)

---

### After Work (Evening)
- [ ] Transfer handwritten notes to Obsidian
- [ ] Create daily note in `work/ST-Engineering/daily-notes/2025-12-08.md`
- [ ] Update answers in question document
- [ ] Review first task requirements
- [ ] Read "Spring Boot in Action" Ch 1 (1 hour)
- [ ] Get good rest! 😴

---

## Day 2: Tuesday, December 9, 2025

### Morning (8:00 AM-12:00 PM)

#### Daily Standup (Typical 9:00 AM)
- [ ] Attend first daily standup
- [ ] Listen and observe format:
  - What did I do yesterday?
  - What will I do today?
  - Any blockers?

- [ ] Your update (keep it brief):
  ```
  Yesterday: Completed onboarding, set up dev environment, got first task
  Today: Continue environment setup, start working on [task]
  Blockers: None yet, still learning the codebase
  ```

- [ ] Note down team's updates
- [ ] Identify who's working on what

#### Work on First Task (9:30 AM-12:00 PM)
- [ ] Review task requirements again
- [ ] Read related code:
  - [ ] Understand existing implementation
  - [ ] Identify where changes needed
  - [ ] Check for similar patterns in codebase

- [ ] Ask clarifying questions to buddy/mentor
- [ ] Start coding (small steps):
  - [ ] Write failing test first (TDD approach)
  - [ ] Implement minimal solution
  - [ ] Ensure tests pass locally

**Focus**: Understanding > Speed. It's okay to go slow.

---

### Afternoon (1:00-5:00 PM)

#### Continue First Task (1:00-3:00 PM)
- [ ] Complete implementation
- [ ] Write unit tests
- [ ] Achieve test coverage target (aim for 80%+)
- [ ] Run full test suite locally:
  ```bash
  ./mvnw test
  # or
  ./gradlew test
  ```

- [ ] Manual testing:
  - [ ] Test in local environment
  - [ ] Verify all edge cases
  - [ ] Test error scenarios

#### Learn CI/CD Pipeline (3:00-4:00 PM)
- [ ] Access Jenkins/CI-CD tool
- [ ] Review existing pipelines:
  - [ ] Build stage
  - [ ] Test stage
  - [ ] Quality checks (SonarQube)
  - [ ] Deploy stage

- [ ] Understand pipeline configuration:
  - [ ] Jenkinsfile location
  - [ ] Pipeline stages
  - [ ] How to trigger builds

- [ ] Watch buddy trigger a build
- [ ] Understand build failures and debugging

**Critical Questions to Ask**:
- ✅ Q2.1: CI/CD tool details?
- ✅ Q2.2: Deployment process?
- ✅ Q2.4: Environment URLs?

#### Code Review Observation (4:00-5:00 PM)
- [ ] Observe code review process:
  - [ ] How PRs are created
  - [ ] Review comments format
  - [ ] Approval process
  - [ ] Merge process

- [ ] Read recent PRs to understand:
  - [ ] Code style expectations
  - [ ] Common feedback patterns
  - [ ] Testing expectations
  - [ ] Documentation requirements

**Critical Questions to Ask**:
- ✅ Q1.7: Code review process?
- ✅ Q6.1: Coding standards?
- ✅ Q6.2: Testing strategy?

---

### After Work
- [ ] Read "Spring Boot in Action" Ch 2 (1 hour)
- [ ] Watch Jenkins course videos (1 hour)
- [ ] Update daily note and learning log
- [ ] Prepare questions for tomorrow

---

## Day 3: Wednesday, December 10, 2025

### Morning (8:00 AM-12:00 PM)

#### Daily Standup
- [ ] Share progress on first task
- [ ] Mention any blockers or questions
- [ ] Listen to team updates

#### Complete First Task (9:00 AM-11:00 AM)
- [ ] Finalize code changes
- [ ] Run full test suite
- [ ] Check code quality:
  ```bash
  # If using Maven with SonarQube
  ./mvnw sonar:sonar

  # Check code coverage
  ./mvnw jacoco:report
  ```

- [ ] Review your own code:
  - [ ] Remove debug statements
  - [ ] Check for code smells
  - [ ] Verify naming conventions
  - [ ] Ensure proper error handling
  - [ ] Add meaningful comments where needed

#### Create First Pull Request (11:00 AM-12:00 PM)
- [ ] Commit changes:
  ```bash
  git add .
  git commit -m "TICKET-123: Brief description of changes

  - Detailed change 1
  - Detailed change 2

  Tests:
  - Added unit tests for X
  - Verified Y scenario
  "
  ```

- [ ] Push to remote:
  ```bash
  git push origin feature/TICKET-123-description
  ```

- [ ] Create Pull Request:
  - [ ] Use PR template if available
  - [ ] Write clear description
  - [ ] Link to Jira ticket
  - [ ] Add screenshots if UI changes
  - [ ] Request reviewers (ask buddy who should review)

- [ ] Update Jira ticket status (In Progress → In Review)

**PR Description Template**:
```markdown
## Summary
Brief description of what this PR does

## Changes
- Change 1
- Change 2

## Testing
- [ ] Unit tests added/updated
- [ ] Manual testing completed
- [ ] All tests passing locally

## Related Ticket
TICKET-123

## Screenshots (if applicable)
[Add screenshots]

## Questions/Notes
Any questions for reviewers
```

---

### Afternoon (1:00-5:00 PM)

#### Learn Monitoring & Logging (1:00-3:00 PM)
- [ ] Access monitoring dashboards
- [ ] Understand key metrics:
  - [ ] Response times
  - [ ] Error rates
  - [ ] Request volumes
  - [ ] Resource utilization

- [ ] Learn logging system:
  - [ ] How to search logs
  - [ ] Log levels (DEBUG, INFO, WARN, ERROR)
  - [ ] Structured logging format
  - [ ] How to add logs in code

- [ ] Practice searching for logs:
  - [ ] Find logs for your service
  - [ ] Search by timestamp
  - [ ] Filter by log level
  - [ ] Trace requests across services

**Critical Questions to Ask**:
- ✅ Q8.1: Monitoring tools?
- ✅ Q8.2: Logging strategy?
- ✅ Q8.4: Distributed tracing?

#### Study Codebase (3:00-5:00 PM)
- [ ] Deep dive into key areas:
  - [ ] Service layer patterns
  - [ ] Repository/DAO patterns
  - [ ] DTO/Entity mappings
  - [ ] Exception handling strategy
  - [ ] Validation approach

- [ ] Create architecture diagram:
  - [ ] Draw high-level component diagram
  - [ ] Identify key classes and relationships
  - [ ] Understand data flow

- [ ] Document findings in Obsidian:
  - [ ] Code patterns used
  - [ ] Naming conventions
  - [ ] Common pitfalls to avoid

---

### After Work
- [ ] Address PR feedback if received
- [ ] Read "Pro Git" Ch 3 (Git Branching) - 1 hour
- [ ] Practice Git commands:
  ```bash
  # Interactive rebase
  git rebase -i HEAD~3

  # Cherry-pick
  git cherry-pick <commit-hash>

  # Stash
  git stash
  git stash pop
  ```
- [ ] Update learning log

---

## Day 4: Thursday, December 11, 2025

### Morning (8:00 AM-12:00 PM)

#### Daily Standup
- [ ] Share PR status
- [ ] Mention learnings from code review
- [ ] Next steps

#### Address PR Feedback (9:00 AM-11:00 AM)
- [ ] Review feedback from reviewers
- [ ] Ask questions if feedback unclear
- [ ] Make requested changes:
  - [ ] Update code
  - [ ] Add/modify tests
  - [ ] Update documentation

- [ ] Push updates:
  ```bash
  git add .
  git commit -m "Address PR feedback: [summary]"
  git push origin feature/TICKET-123-description
  ```

- [ ] Reply to reviewers:
  - [ ] Thank them for feedback
  - [ ] Explain changes made
  - [ ] Ask for re-review

#### Database Deep Dive (11:00 AM-12:00 PM)
- [ ] Access dev database
- [ ] Understand schema:
  - [ ] Key tables
  - [ ] Relationships (foreign keys)
  - [ ] Indexes
  - [ ] Constraints

- [ ] Review migration scripts:
  - [ ] Flyway or Liquibase files
  - [ ] Migration naming conventions
  - [ ] How to create new migrations

**Critical Questions to Ask**:
- ✅ Q6.3: Dependency management?
- ✅ Q7.5: Caching strategy?
- ✅ Q7.6: Database connection pooling?

---

### Afternoon (1:00-5:00 PM)

#### Learn Testing Practices (1:00-3:00 PM)
- [ ] Study existing tests:
  - [ ] Unit test examples
  - [ ] Integration test examples
  - [ ] Mock usage patterns
  - [ ] Test data setup

- [ ] Understand test infrastructure:
  - [ ] Test base classes
  - [ ] Test utilities
  - [ ] Test configuration
  - [ ] TestContainers usage (if any)

- [ ] Run tests locally:
  ```bash
  # Run all tests
  ./mvnw test

  # Run specific test class
  ./mvnw test -Dtest=UserServiceTest

  # Run with coverage
  ./mvnw test jacoco:report
  ```

#### Shadow Senior Developer (3:00-5:00 PM)
- [ ] Pair programming session (if available):
  - [ ] Observe their workflow
  - [ ] Ask about their approach
  - [ ] Learn keyboard shortcuts
  - [ ] Understand debugging techniques

- [ ] Or review their recent PRs:
  - [ ] Study code quality
  - [ ] Learn design patterns used
  - [ ] Note best practices

---

### After Work
- [ ] Start "SQL Performance Explained" (online book) - 1 hour
- [ ] Install VisualVM if not done
- [ ] Practice Java profiling basics
- [ ] Update weekly learning log

---

## Day 5: Friday, December 12, 2025

### Morning (8:00 AM-12:00 PM)

#### Daily Standup
- [ ] Share week's accomplishments
- [ ] Mention blockers or questions
- [ ] Plan for next week

#### Merge First PR (9:00 AM-10:00 AM)
- [ ] Final review of PR
- [ ] Ensure all checks passing:
  - [ ] Build successful
  - [ ] Tests passing
  - [ ] Code quality checks passing
  - [ ] All approvals received

- [ ] Merge PR (or ask reviewer to merge)
- [ ] Update Jira ticket (In Review → Done)
- [ ] Celebrate small win! 🎉

#### Deploy to Dev Environment (10:00 AM-11:00 AM)
- [ ] Understand deployment process
- [ ] Watch or participate in deployment:
  - [ ] Trigger pipeline
  - [ ] Monitor build progress
  - [ ] Verify deployment success
  - [ ] Check application health

- [ ] Verify your changes in dev environment:
  - [ ] Test functionality
  - [ ] Check logs
  - [ ] Verify metrics

**Critical Questions to Ask**:
- ✅ Q2.3: Container strategy?
- ✅ Q10.1: Cloud provider?
- ✅ Q10.2: Cloud services used?

#### Sprint Ceremonies (11:00 AM-12:00 PM)
- [ ] Sprint Review (if scheduled):
  - [ ] Observe format
  - [ ] See what teams demo
  - [ ] Note stakeholder feedback

---

### Afternoon (1:00-5:00 PM)

#### Sprint Retrospective (1:00-2:00 PM)
- [ ] Participate in retrospective:
  - [ ] Share onboarding experience (if appropriate)
  - [ ] Listen to team's feedback
  - [ ] Understand team dynamics

#### Week 1 Review (2:00-3:00 PM)
- [ ] Review accomplishments:
  - ✅ Environment set up
  - ✅ First PR merged
  - ✅ First deployment
  - ✅ Met team members
  - ✅ Learned tools and processes

- [ ] Identify gaps:
  - What do I still not understand?
  - What do I need to learn next week?
  - Who can help me with what?

- [ ] Update skills tracker
- [ ] Complete Week 1 learning log

#### 1-on-1 with Manager (3:00-3:30 PM)
- [ ] First check-in with manager:
  - [ ] Share week's experience
  - [ ] Ask about expectations
  - [ ] Clarify any concerns
  - [ ] Get feedback

- [ ] Discuss:
  - How am I doing so far?
  - What should I focus on next week?
  - Any adjustments needed?
  - 30-60-90 day goals

**Questions to Ask Manager**:
- ✅ Q12.3: 30-60-90 day expectations?
- ✅ Q12.4: 1-on-1 frequency?

#### Knowledge Sharing Session (4:00-5:00 PM)
- [ ] Brown bag session (if scheduled)
- [ ] Or: Self-study time
  - [ ] Document week's learnings
  - [ ] Update Obsidian knowledge base
  - [ ] Organize notes and code examples

---

### After Work / Weekend

#### Friday Evening
- [ ] Complete Week 1 reflection (below)
- [ ] Update all tracking documents
- [ ] Prepare for Week 2
- [ ] Celebrate first week! 🎊

#### Weekend Learning (Optional - 4 hours)
- [ ] Saturday (2 hours):
  - [ ] Read "Spring Boot in Action" Ch 3-4
  - [ ] Practice: Build simple Spring Boot app with Actuator
  - [ ] Document learnings

- [ ] Sunday (2 hours):
  - [ ] Watch Jenkins course (2 hours)
  - [ ] Create Jenkins pipeline for personal project
  - [ ] Review week's notes
  - [ ] Plan Week 2 focus areas

---

## Week 1 Success Metrics

### Technical Achievements ✅
- [ ] Development environment fully set up
- [ ] Built project successfully locally
- [ ] Ran application locally
- [ ] Created first branch
- [ ] Committed first code
- [ ] Created first PR
- [ ] Merged first PR
- [ ] Deployed to dev environment

**Score**: ____ / 8

---

### Tool & Access ✅
- [ ] Git access
- [ ] Jira access
- [ ] Confluence access
- [ ] Jenkins/CI-CD access
- [ ] Database access
- [ ] Cloud platform access
- [ ] Monitoring tool access
- [ ] Communication platforms

**Score**: ____ / 8

---

### Knowledge Gained ✅
- [ ] Understand team structure
- [ ] Understand project architecture
- [ ] Understand branching strategy
- [ ] Understand code review process
- [ ] Understand testing requirements
- [ ] Understand deployment process
- [ ] Understand monitoring approach
- [ ] Met all team members

**Score**: ____ / 8

---

### Relationships Built ✅
- [ ] Manager/Team lead
- [ ] Onboarding buddy
- [ ] 2-3 team members
- [ ] DevOps/Infrastructure contact
- [ ] QA contact (if applicable)
- [ ] Product manager (if applicable)

**Score**: ____ / 6

---

### Total Week 1 Score: ____ / 30

**Rating**:
- 25-30: Excellent first week! 🌟
- 20-24: Great progress! 👍
- 15-19: Good start, keep going! 💪
- <15: Need to accelerate, ask for help

---

## Week 1 Reflections

### What Went Well 🎉
1. _____
2. _____
3. _____

### What Was Challenging 😅
1. _____
2. _____
3. _____

### Key Learnings 📚
**Technical**:
1. _____
2. _____
3. _____

**Process**:
1. _____
2. _____
3. _____

**Team/Culture**:
1. _____
2. _____
3. _____

### Surprises 😮
**Positive**:
- _____
- _____

**Negative/Concerns**:
- _____
- _____

### Questions Still Unanswered ❓
1. _____
2. _____
3. _____

### Action Items for Week 2 📋
**Technical Skills to Develop**:
- [ ] _____
- [ ] _____
- [ ] _____

**Relationships to Build**:
- [ ] _____
- [ ] _____

**Processes to Learn**:
- [ ] _____
- [ ] _____

### Feedback Received 💬
**From Manager**:
- _____

**From Buddy/Mentor**:
- _____

**From Code Reviews**:
- _____

### Self-Assessment
**Confidence Level**: ____ / 10

**Areas I feel strong**:
- _____
- _____

**Areas I need help**:
- _____
- _____

**Biggest win this week**:
- _____

**One thing I'd do differently**:
- _____

---

## Week 2 Preview & Goals

### Technical Goals
- [ ] Complete 2-3 tasks independently
- [ ] Start contributing to code reviews
- [ ] Set up local Jenkins pipeline
- [ ] Optimize first slow query
- [ ] Write integration test with TestContainers

### Learning Goals
- [ ] Complete "Spring Boot in Action" Ch 1-4, 7
- [ ] Complete Jenkins course
- [ ] Start "SQL Performance Explained"
- [ ] Learn monitoring tools deeply
- [ ] Understand microservices communication

### Relationship Goals
- [ ] Have coffee chat with 2 team members
- [ ] Pair program with senior developer
- [ ] Help another team member (if opportunity arises)
- [ ] Present learnings in team meeting (if appropriate)

### Process Goals
- [ ] Create first deployment independently
- [ ] Participate actively in code reviews
- [ ] Contribute idea in sprint planning
- [ ] Document process gaps (if any)

---

## Daily Schedule Template (Week 1)

### Morning Routine
**7:30 AM**: Wake up, exercise, breakfast
**8:00 AM**: Review yesterday's notes, plan today
**8:30 AM**: Commute or start work (if remote)
**9:00 AM**: Daily standup
**9:30 AM**: Focus work block

### Work Day
**12:00 PM**: Lunch break
**1:00 PM**: Afternoon work block
**3:00 PM**: Meetings or collaboration time
**5:00 PM**: End of day review, tomorrow planning
**5:30 PM**: Commute home

### Evening Routine
**6:30 PM**: Dinner
**7:30 PM**: Learning time (1-1.5 hours)
- Read book chapter OR
- Watch course videos OR
- Hands-on practice
**9:00 PM**: Update notes and learning log
**9:30 PM**: Personal time, relax
**10:30 PM**: Sleep

---

## Emergency Protocols

### If You're Blocked on a Task
1. ⏱️ Try to solve for 30 minutes independently
2. 🔍 Search documentation, Confluence, Stack Overflow
3. 💬 Ask in team Slack channel (30 min mark)
4. 🤝 Request help from buddy (1 hour mark)
5. 🆘 Escalate to team lead (2 hour mark)

**Never stay blocked >2 hours without asking for help!**

### If You Make a Mistake
1. ✅ Own it immediately
2. 📢 Communicate impact to team
3. 🔧 Propose solution
4. 📝 Document to prevent recurrence
5. 🎓 Learn and move on

**Mistakes are learning opportunities!**

### If You're Overwhelmed
1. 🛑 Take a short break (5-10 min walk)
2. 📋 Write down everything on your mind
3. 🎯 Prioritize: What's urgent? What can wait?
4. 💬 Talk to buddy or manager
5. ⚖️ Remember: It's normal to feel overwhelmed in Week 1

**Be kind to yourself!**

---

## Tips for Success

### Do's ✅
1. **Ask questions** - No question is too basic in Week 1
2. **Take notes** - You won't remember everything
3. **Be proactive** - Volunteer for tasks
4. **Be punctual** - Show respect for others' time
5. **Over-communicate** - Especially when remote
6. **Listen actively** - In meetings and conversations
7. **Say thank you** - Appreciate people's help
8. **Admit when you don't know** - Honesty builds trust
9. **Document as you learn** - Future you will thank you
10. **Celebrate small wins** - Merged PR? Celebrate!

### Don'ts ❌
1. **Don't pretend to understand** - Ask for clarification
2. **Don't work in isolation** - Reach out early
3. **Don't skip breaks** - Prevent burnout from Day 1
4. **Don't compare yourself to others** - Everyone's path is different
5. **Don't be afraid of mistakes** - They're learning opportunities
6. **Don't gossip** - Builds negative impression
7. **Don't complain** - Stay positive and solution-oriented
8. **Don't work excessive hours** - Sustainable pace wins
9. **Don't forget to eat/sleep** - Health comes first
10. **Don't stress too much** - You were hired for a reason!

---

## Communication Templates

### Asking for Help
```
Hi [Name],

I'm working on [task/ticket] and I'm stuck on [specific issue].

What I've tried:
1. [Attempt 1]
2. [Attempt 2]

Error message: [paste error if applicable]

Could you help me understand [specific question]?

Thanks!
Khoa
```

### Providing Status Update
```
Hi [Manager/Team],

Quick update on [task/ticket]:

✅ Completed:
- [Item 1]
- [Item 2]

🔄 In Progress:
- [Item 3] (50% done)

⏰ Next:
- [Item 4]

🚧 Blockers:
- None / [Specific blocker]

ETA: [Date]
```

### Admitting a Mistake
```
Hi [Manager/Team],

I made an error in [what went wrong].

Impact: [Describe impact]

Root cause: [What I did wrong]

Fix: [What I'm doing to fix it]

Prevention: [How I'll prevent this in future]

Apologies for the inconvenience.

Khoa
```

---

## Week 1 Checklist Summary

### Must Complete ✅
- [ ] All access granted and working
- [ ] Development environment fully set up
- [ ] Built and ran application locally
- [ ] Met all team members
- [ ] Attended all ceremonies
- [ ] Completed at least 1 task
- [ ] Created at least 1 PR
- [ ] Completed Week 1 learning log

### Should Complete 🎯
- [ ] Merged first PR
- [ ] Deployed to dev environment
- [ ] Understood architecture
- [ ] Started learning resources
- [ ] Built relationship with buddy
- [ ] Asked meaningful questions

### Nice to Complete 🌟
- [ ] Started second task
- [ ] Contributed to code review
- [ ] Set up local monitoring
- [ ] Completed first book chapter
- [ ] Created architecture diagram

---

**Remember**: Week 1 is about learning and relationship-building, not about delivering massive value. Be patient with yourself, ask lots of questions, and enjoy the journey!

Good luck! You've got this! 🚀

---

**Last Updated**: December 7, 2025
**Next Review**: End of Week 1 (December 14, 2025)

## Related Documents
- [[plans/ST-Engineering-Learning-Plan]] - 3-month roadmap
- [[plans/ST-Engineering-First-Day-Questions]] - Comprehensive question list
- [[CLAUDE.md]] - Knowledge base and skills assessment

## Tags
#onboarding #first-week #checklist #career #ST-Engineering #daily-routine
