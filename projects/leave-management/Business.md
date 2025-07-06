# June 30 2025
- Table `leave_request_approval_history` is a duplicate version of `leave_approval_steps`, so consider:
	- Turn `leave_approval_step` to dynamically configure the workflow of leave approval, which is similar to HCMUT HRM.
	- Turn `leave_request_approval_history` into a history snapshot of the leave. The approver staff is now granted permission to edit the content of the leave, so table`leave_request` contains the newest information about the leave and the `leave_request_approval_history` contains the previous snapshot of the form whenever it is changed by the approver.
- Each leave type has its own workflow step template:
|id|workflow_template_id|step_order|approver_role|description|
|---|---|---|---|---|

|   |   |   |   |   |
|---|---|---|---|---|
|1|1|1|LINE_MANAGER|Direct Manager must approve|

|   |   |   |   |   |
|---|---|---|---|---|
|2|1|2|DEPARTMENT_HEAD|Department Head must approve|

|     |     |     |     |                             |     |
| --- | --- | --- | --- | --------------------------- | --- |
| 3   | 1   | 3   | HR  | HR must give final approval |     |
|     |     |     |     |                             |     |
|     |     |     |     |                             |     |
- The question is that should we save the name or the id of approver role.
# July 5 2025
- There is no application snapshot because the approver cannot make any modification to the leave request. He is able to accept, reject or return the application to the applicant. If the request is returned, the applicant is allowed to modify the application.
- 
