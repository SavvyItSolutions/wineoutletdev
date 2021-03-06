USE [Hangouts]
GO
/****** Object:  Table [dbo].[VerificationMail]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VerificationMail](
	[DbKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[ActivationCode] [nvarchar](max) NULL,
	[Verified] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[DbKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[VerificationMail]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[ICSCustomers] ([CustomerID])
GO
