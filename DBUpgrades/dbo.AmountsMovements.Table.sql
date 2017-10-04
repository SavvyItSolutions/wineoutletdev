USE [Hangouts]
GO
/****** Object:  Table [dbo].[AmountsMovements]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmountsMovements](
	[WineID] [int] NULL,
	[LabelName] [varchar](max) NULL,
	[Barcode] [nvarchar](max) NULL,
	[movementDate] [datetime] NULL,
	[CustomerId] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
