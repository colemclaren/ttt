
-- Serverside only.
if ( CLIENT ) then return end

local setmetatable 	= setmetatable
local tostring 		= tostring
local table			= table
require( "ai_task_slv" )
local ai_task_slv = ai_task_slv

module( "ai_schedule_slv" )

-- Define the Schedule object

local Schedule = {}
Schedule.__index = Schedule

--[[---------------------------------------------------------
    Name: Init
	Sets the object up. Called automatically from ai_schedule_slv.new.
-----------------------------------------------------------]]
function Schedule:Init( _debugname_ ) 

	self.DebugName 	= tostring( _name_ )
	self.Tasks 		= {}
	self.TaskCount 	= 0
	
end

--[[---------------------------------------------------------

    Adds an engine task to the schedule
	
	schd:EngTask( "TASK_TARGET_PLAYER", 		0 )
	
-----------------------------------------------------------]]
function Schedule:EngTask( _taskname_, _taskdata_ )

	local NewTask = ai_task_slv.New()
	NewTask:InitEngine( _taskname_, _taskdata_ )
	table.insert( self.Tasks, NewTask )
	self.TaskCount = self.TaskCount +1
	
end

--[[---------------------------------------------------------

    Adds Lua NPC task to the schedule
	
	schdChase:AddTask( "LookForPlayer", "AnyDataYouWant" )
	
	will call the functions 
	
	NPC:TaskStart_LookForPlayer( "AnyDataYouWant" )	- once on start
	NPC:Task_LookForPlayer( "AnyDataYouWant" ) 		- every think until TaskComplete

-----------------------------------------------------------]]
function Schedule:AddTask( _functionname_, _data_ )

	local NewTask = ai_task_slv.New()
	NewTask:InitFunctionName( "TaskStart_" .. _functionname_, "Task_" .. _functionname_, _data_ )
	table.insert( self.Tasks, NewTask )
	self.TaskCount = self.TaskCount +1
	
end

--[[---------------------------------------------------------

    The same as above but you get to specify the exact 
		function name to call

-----------------------------------------------------------]]
function Schedule:AddTaskEx( _start, _run, _data_ )

	local NewTask = ai_task_slv.New()
	NewTask:InitFunctionName( _start, _run, _data_ )
	table.insert( self.Tasks, NewTask )
	self.TaskCount = self.TaskCount +1
	
end

--[[---------------------------------------------------------
    Name: NumTasks
-----------------------------------------------------------]]
function Schedule:NumTasks()
	return self.TaskCount
end

--[[---------------------------------------------------------
    Name: GetTask
-----------------------------------------------------------]]
function Schedule:GetTask( num )
	return self.Tasks[ num ]
end


--[[---------------------------------------------------------
	Create a new empty task (this is ai_schedule_slv.New )
-----------------------------------------------------------]]
function New( debugname )

	local pNewSchedule = {}
	setmetatable( pNewSchedule, Schedule )
	
	pNewSchedule:Init( debugname )
	
	return pNewSchedule

end
