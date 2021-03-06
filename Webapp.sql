USE [master]
GO

CREATE DATABASE [APPDB]

GO
USE [APPDB]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[BuildingID] [int] IDENTITY(1,1) NOT NULL,
	[BuildingName] [nvarchar](500) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobDepartment](
	[JobDepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[JobTitle] [nvarchar](50) NOT NULL,
	[JobTypeId] [int] NOT NULL,
 CONSTRAINT [PK_JobDepartment] PRIMARY KEY CLUSTERED 
(
	[JobDepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobRole](
	[JobTypeID] [int] IDENTITY(1,1) NOT NULL,
	[JobTypeRole] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_JobRole] PRIMARY KEY CLUSTERED 
(
	[JobTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[ManagerID] [int] NULL,
	[BuildingID] [int] NOT NULL,
	[JobDepartmentId] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwEmployeeDetails]
AS
SELECT        U.UserID, U.FirstName + '	' + U.LastName AS FullName, M.UserID AS ManagerID, M.FirstName + '_' + M.LastName AS ManagerName, JD.JobTitle, JR.JobTypeRole, B.Address AS NuildingAddress
FROM            dbo.[User] AS U INNER JOIN
                         dbo.[User] AS M ON U.ManagerID = M.UserID INNER JOIN
                         dbo.JobDepartment AS JD ON JD.JobDepartmentID = U.JobDepartmentId INNER JOIN
                         dbo.JobRole AS JR ON JD.JobTypeId = JR.JobTypeID INNER JOIN
                         dbo.Building AS B ON B.BuildingID = U.BuildingID

GO
SET IDENTITY_INSERT [dbo].[Building] ON 

INSERT [dbo].[Building] ([BuildingID], [BuildingName], [Address]) VALUES (1, N'Empire State Building', N'West 33rd and 34th Streets in Midtown, Manhattan, New York City')
INSERT [dbo].[Building] ([BuildingID], [BuildingName], [Address]) VALUES (2, N'Chrysler Building', N'The Chrysler Building is an Art Deco-style skyscraper located on the East Side of Midtown Manhattan in New York City')
SET IDENTITY_INSERT [dbo].[Building] OFF
SET IDENTITY_INSERT [dbo].[JobDepartment] ON 

INSERT [dbo].[JobDepartment] ([JobDepartmentID], [JobTitle], [JobTypeId]) VALUES (1, N'Sales', 1)
INSERT [dbo].[JobDepartment] ([JobDepartmentID], [JobTitle], [JobTypeId]) VALUES (2, N'Sales', 2)
INSERT [dbo].[JobDepartment] ([JobDepartmentID], [JobTitle], [JobTypeId]) VALUES (3, N'Marketing', 1)
INSERT [dbo].[JobDepartment] ([JobDepartmentID], [JobTitle], [JobTypeId]) VALUES (4, N'Marketing', 2)
SET IDENTITY_INSERT [dbo].[JobDepartment] OFF
SET IDENTITY_INSERT [dbo].[JobRole] ON 

INSERT [dbo].[JobRole] ([JobTypeID], [JobTypeRole]) VALUES (1, N'Manager')
INSERT [dbo].[JobRole] ([JobTypeID], [JobTypeRole]) VALUES (2, N'Worker')
SET IDENTITY_INSERT [dbo].[JobRole] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (1, N'SMITH', N'JOHNSON', NULL, 1, 1)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (2, N'WILLIAMS', N'BROWN', NULL, 2, 3)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (4, N'RODRIGUEZ', N'MARTINEZ', 1, 1, 2)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (5, N'ANDERSON', N'TAYLOR', 1, 1, 2)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (6, N'MOORE', N'MARTIN', 1, 1, 2)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (7, N'ROBINSON', N'WALKER', 2, 2, 4)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (8, N'SANCHEZ', N'GREEN', 2, 2, 4)
INSERT [dbo].[User] ([UserID], [FirstName], [LastName], [ManagerID], [BuildingID], [JobDepartmentId]) VALUES (9, N'STEWART', N'NGUYEN', 2, 2, 4)
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[JobDepartment]  WITH CHECK ADD  CONSTRAINT [FK_JobDepartment_JobRole] FOREIGN KEY([JobTypeId])
REFERENCES [dbo].[JobRole] ([JobTypeID])
GO
ALTER TABLE [dbo].[JobDepartment] CHECK CONSTRAINT [FK_JobDepartment_JobRole]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Building] FOREIGN KEY([BuildingID])
REFERENCES [dbo].[Building] ([BuildingID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Building]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_JobDepartment] FOREIGN KEY([JobDepartmentId])
REFERENCES [dbo].[JobDepartment] ([JobDepartmentID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_JobDepartment]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "U"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "M"
            Begin Extent = 
               Top = 6
               Left = 673
               Bottom = 135
               Right = 853
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "JD"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 118
               Right = 427
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "JR"
            Begin Extent = 
               Top = 6
               Left = 465
               Bottom = 101
               Right = 635
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 118
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwEmployeeDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwEmployeeDetails'
GO
USE [master]
GO
ALTER DATABASE [APPDB] SET  READ_WRITE 
GO
