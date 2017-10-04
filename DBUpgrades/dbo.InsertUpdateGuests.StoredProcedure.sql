USE [Hangouts]
GO
/****** Object:  StoredProcedure [dbo].[InsertUpdateGuests]    Script Date: 30-06-2017 07:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[InsertUpdateGuests]
(
	@devicetoken varchar(max),
	@devicetype int
)
as
begin
	insert into guests select getdate(),@devicetoken,@devicetype;
	select scope_identity();
end
GO
