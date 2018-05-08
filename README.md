## Collaboration Workflow

1. Create your own working branch of the repository
2. Pick a piece of work out of the backlog
3. Do the work against your working branch
4. Push the working branch to GitHub
5. Open a Pull Request against the main working branch
6. Teammate reviews the PR
   * If review approved, teammate merges PR
   * If changes requested, return to step 3

## Issues Workflow

All work needing to be done should have an associated GitHub issue.
Every issue must be labeled with one of each of the following types of label:

- component: What component of the project is this work being done for
- status: What is the current status of this work

#### Project components

- front end: The browser application for consuming the API
- api: The public interface for exploring and analyzing data
- database: The organizational and relational design of the data itself
- pipeline: The scripts which automate addition of new data to the database
- documentation: Creation of instructional material which makes the project usable
- data analysis: Data sciency stuff around doing black magic with the data

#### Work status workflow

```
ready ──────────────────────┐
 ↓                          │
in progress ←→ blocked ─────┤
 ↓↑                         │
awaiting review ────────────┤
 ↓                          ↓
completed                abandoned
```

#### Work status definitions

Open states

- ready: This issue is ready to be worked.
- in progress: This issue is being worked on. Issues in this status **must** have an assignee
- blocked: Work on this issue cannot be completed until some other piece of work is completed. When placing an issue into this state, a comment **must** be added to the ticket describing the blocker, providing links whenever possible.
- awaiting review: Work on this issue is completed and awaiting peer review. In this state, the issue **must** either have no assignee or be assigned to the teammate responsible for performing the review. When placing an issue into this state, a comment **must** be added to the ticket describing how a reviewer can retrieve and review the work. Links to PRs/commits are ideal.

Closed states

- completed: The reviewer has approved of the work and it has been merged. The reviewer is responsible for merging the work, closing the issue, and applying the "completed" tag to the closed issue.
- abandoned: Work on this issue cannot or will not be completed. The team member closing the issue is responsible for applying this tag.
