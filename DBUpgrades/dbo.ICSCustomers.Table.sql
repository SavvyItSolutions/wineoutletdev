USE [Hangouts]
GO
/****** Object:  Table [dbo].[ICSCustomers]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ICSCustomers](
	[CustomerID] [int] NULL,
	[FirstName] [varchar](max) NULL,
	[LastName] [varchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Phone2] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Address1] [nvarchar](100) NULL,
	[Address2] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[CustomerType] [nvarchar](100) NULL,
	[CustomerAdded] [varchar](128) NULL,
	[CardNumber] [varchar](50) NULL,
	[Notes1] [varchar](max) NULL,
	[IsUpdated] [tinyint] NULL,
	[LastUpdatedOn] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ICSCustomers] ADD  DEFAULT ((0)) FOR [IsUpdated]
GO
