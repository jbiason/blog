+++
title = "Thrifty Rubidium"
date = 2022-06-14

[taxonomies]
tags = ["projects", "personal", "make", "runner"]
+++

Task Runner.

The basic idea is to have a bunch of tasks, and each task have a step. Based on
the parallelism available (number of cores, for example), the system would
launch each step on each task as long as there is available processing power.

Let's start with the definition of task: A task could be, very simply, a
directory with a runner configuration file, where the steps are defined. For
example:

```json
{
	"name": "ExampleTask",
	"steps": [
		{
			"name": "Get List",
			"command": "ls > file.ls"
		},
		{
			"name": "Find file",
			"command": "grep somename file.ls"
		},
		{
			"name": "Remove file",
			"command": "rm file.ls"
		}
	]
}
```

If one of the steps fails, the whole task stops. For example, if grep returns
an error code, "Rmeove file" would not be run.

{% note() %}
**Thought**: Maybe we could add a flag on each step to point that the steps
should keep going even in case of error.
{% end %}

The first step is to walk all directories, trying to find out which ones
contain the task configuration file. Once found, it will be added to the list
of running tasks, and the steps will start running.

One multiple tasks we could have something like this
([TUI](https://github.com/fdehau/tui-rs) idea, also):

```
Task         Step 1        Step 2         Step 3           Step 4
ExampleTask  Get list (R)  Find file (W)  Remove file (W)
Task2        Step21 (D)    Step 22 (R)    Step 23 (W)      Step 24 (W)
Task3        Step31 (R)    Step 32 (W)    Step 33 (W)
Task4        Step41 (D)    Step 42 (R)
Task5        Step51 (E)    Step 52 (S)    Step 53 (S)
```

In this example, there are 4 available cores, so only 4 steps can run at the
same time; those are marked as `(R)` for Running. Once the step is Done, marked
as `(D)`, task can move to the next step. Steps marked with `(W)` are Waiting
for their time to be run, which requires the previous step to be marked as Done
and having enough cores available. If a step errors, `(E)`, the task stops
running and the next steps are marked as Skipped, `(S)`.

The structures to load the tasks is pretty simple:

```rust
pub struct Case {
	name: String,
	steps: Vec<Step>
}

pub struct Step {
	name: String,
	command: Command,
}

pub struct Command {
	command: String,
	name: String,
}
```

After reading the data from the disk, the code could check if the step is "valid", 
like checking if the command exists and can be called. The `Command` doesn't
exist in the configuration file, but it is generated while being loaded; the
command itself it is the command specificed in the runner configuration file,
but its main component is extracted and put in the name, to make it easier to
display to the user; for example `/usr/bin/ls -lha` in the configuration file
would have the same value in the `command` field, but the `name` would be
simply "ls".

For every structure, they is a "sister" structure "Run", with the results of
the execution:

```rust
pub struct CaseRun {
	case: &Case,
	status: CaseRunStatus,
}

pub enum CaseRunStatus {
	PendingSteps,		// there are still steps to be run in this case
	Completed,		// no more steps available
	Error,			// one step failed and it shouldn't run anymore
}

pub struct StepRun {
	step: &Step,
	status: StepRunStatus,
	output: String,
}

pub enum StepRunStatus {
	Waiting,
	Running,
	Done,
	Error,
	Skipped,
}
```
