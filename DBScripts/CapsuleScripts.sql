USE [master]
GO

CREATE DATABASE [TaskManager]
 GO

USE [TaskManager]
GO


CREATE TABLE [dbo].[Parent_Task](
	[Parent_ID] [int] NULL,
	[Parent_Task] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Task]    Script Date: 9/6/2018 12:33:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[Task_ID] [int] NULL,
	[Parent_ID] [int] NULL,
	[Task] [varchar](500) NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
	[Priority] [int] NULL,
	[IsActive] [int] NULL
) ON [PRIMARY]

GO


CREATE PROCEDURE [dbo].[GET_PARENT_TASK]

AS

BEGIN

	SELECT * FROM Parent_Task;

END
GO
/****** Object:  StoredProcedure [dbo].[GET_TASK_DETAILS]    Script Date: 9/6/2018 12:33:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_TASK_DETAILS]

AS

BEGIN

	SELECT Task_ID,Parent_ID,Task,CONVERT(date, Start_Date) AS Start_Date ,CONVERT(date, End_Date) AS End_Date,Priority,IsActive FROM Task;

END
GO
/****** Object:  StoredProcedure [dbo].[INSERT_TASK_DETAILS]    Script Date: 9/6/2018 12:33:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_TASK_DETAILS]
(

@Task_ID INT,
@Parent_ID INT,
@Task VARCHAR(500),
@Start_Date DATETIME,
@End_Date DATETIME,
@Priority INT
)

AS

BEGIN

	IF(@Task_ID=0)
		BEGIN

			INSERT INTO Task(Task_ID,Parent_ID,Task,Start_Date,End_Date,Priority,IsActive)VALUES ((select COUNT(*)+1 from Task),@Parent_ID,@Task,@Start_Date,@End_Date,@Priority,1);
			
		END

	ELSE 
		BEGIN
			
		  UPDATE Task SET Parent_ID=@Parent_ID,Task=@Task,Start_Date=@Start_Date,End_Date=@End_Date,Priority=@Priority
		  WHERE Task_ID = @Task_ID;


		END
END
GO
/****** Object:  StoredProcedure [dbo].[UPDATE_END_TASK]    Script Date: 9/6/2018 12:33:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_END_TASK]
(
@Task_ID INT,
@End_Date DATETIME
)

AS

BEGIN

	UPDATE Task SET End_Date=@End_Date,IsActive=0 WHERE Task_ID = @Task_ID;

END
GO
/****** Object:  Table [dbo].[Parent_Task]    Script Date: 9/6/2018 12:33:56 AM ******/

SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [TaskManager] SET  READ_WRITE 
GO


