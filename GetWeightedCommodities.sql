ALTER PROCEDURE [dbo].[GetWeightedCommodities]
	@CommodityId float = null
,	@CountryId nchar(2) = null
,	@OwnershipWeight int = null
,	@CapitalWeight int = null
,	@LaborWeight int = null
,	@LandWeight int = null
AS
BEGIN

	SET NOCOUNT ON;

	if @CommodityId is null	set @CommodityId = '43232309'
	if @CountryId is null	set @CountryId = N'US'
	if @OwnershipWeight is null	set @OwnershipWeight = 100
	if @CapitalWeight is null	set @CapitalWeight = 50
	if @LaborWeight is null	set @LaborWeight = 25
	if @LandWeight is null	set @LandWeight = 5

	if OBJECT_ID('tempdb..#com') is not null drop table #com
	create table #com (
		[UserName] [nvarchar](50),
		[CommodityId] [float],
		[CountryId] [nchar](2),
		[ObjectId] [nvarchar](50)
	)
	insert #com (UserName, CommodityId, CountryId, ObjectId)
			select distinct p.UserName, p.CommodityId, p.CountryId, p.ObjectId
			from [Wares].[dbo].[Percentages] p
			where p.CommodityId = @CommodityId and p.CountryId = @CountryId
	--select * from #com


	if OBJECT_ID('tempdb..#usr') is not null drop table #usr
	create table #usr (
		[UserName] [nvarchar](50)
	)
	insert #usr (UserName)
			select distinct UserName
			from #com
	--select * from #usr


	if OBJECT_ID('tempdb..#usrown') is not null drop table #usrown
	create table #usrown (
		[UserName] [nvarchar](50),
		[CountryId] [nchar](2),
		[WeightedPercentage] [int]
	)
	insert #usrown (UserName, CountryId, WeightedPercentage)
			select p.UserName, p.CountryId, @OwnershipWeight * p.Percentage
			from [Wares].[dbo].[Percentages] p
			join #usr u on p.UserName = u.UserName
			where p.TypeId = 1 and p.CountryId = @CountryId
			union
			select p.UserName, p.CountryId, @OwnershipWeight
			from [Wares].[dbo].[Percentages] p
			join #usr u on p.UserName = u.UserName
			where p.TypeId = 1 and p.CountryId <> @CountryId
	--select * from #usrown


	if OBJECT_ID('tempdb..#usrcap') is not null drop table #usrcap
	create table #usrcap (
		[UserName] [nvarchar](50),
		[CountryId] [nchar](2),
		[WeightedPercentage] [int]
	)
	insert #usrcap (UserName, CountryId, WeightedPercentage)
			select p.UserName, p.CountryId, @CapitalWeight * p.Percentage
			from [Wares].[dbo].[Percentages] p
			join #usr u on p.UserName = u.UserName
			where p.TypeId = 2 and p.CountryId = @CountryId
			union
			select p.UserName, p.CountryId, @CapitalWeight
			from [Wares].[dbo].[Percentages] p
			join #usr u on p.UserName = u.UserName
			where p.TypeId = 2 and p.CountryId <> @CountryId
	--select * from #usrcap


	if OBJECT_ID('tempdb..#result') is not null drop table #result
	create table #result (
		[UserName] [nvarchar](50),
		[NameName] [nvarchar](50),
		[TypeId] [int],
		[CommodityId] [float],
		[CountryId] [nchar](2),
		[WeightedPercentage] [int],
		[ObjectId] [nvarchar](50)
	)
	insert #result (UserName, NameName, TypeId, CommodityId, CountryId, WeightedPercentage, ObjectId)
			select c.UserName, dbo.GetProfileValue(c.UserName, 'Name'), 1, c.CommodityId, c.CountryId, uo.WeightedPercentage, c.ObjectId
			from #com c
			left join #usrown uo on c.UserName = uo.UserName and c.CountryId = uo.CountryId
			union
			select c.UserName, dbo.GetProfileValue(c.UserName, 'Name'), 2, c.CommodityId, c.CountryId, uc.WeightedPercentage, c.ObjectId
			from #com c
			left join #usrcap uc on c.UserName = uc.UserName and c.CountryId = uc.CountryId
			union
			select p.UserName, dbo.GetProfileValue(p.UserName, 'Name'), p.TypeId, p.CommodityId, p.CountryId, (@CapitalWeight * p.Percentage) + ISNULL(uc.WeightedPercentage ,0), p.ObjectId
			from [Wares].[dbo].[Percentages] p
			left join #usrcap uc on p.UserName = uc.UserName and p.CountryId = uc.CountryId
			where p.CommodityId = @CommodityId and p.TypeId = 3 and p.CountryId = @CountryId
			union
			select p.UserName, dbo.GetProfileValue(p.UserName, 'Name'), p.TypeId, p.CommodityId, p.CountryId, (@CapitalWeight) + ISNULL(uc.WeightedPercentage ,0), p.ObjectId
			from [Wares].[dbo].[Percentages] p
			left join #usrcap uc on p.UserName = uc.UserName and p.CountryId = uc.CountryId
			where p.CommodityId = @CommodityId and p.TypeId = 3 and p.CountryId <> @CountryId
			union
			select p.UserName, dbo.GetProfileValue(p.UserName, 'Name'), p.TypeId, p.CommodityId, p.CountryId, (@LaborWeight * p.Percentage), p.ObjectId
			from [Wares].[dbo].[Percentages] p
			where p.CommodityId = @CommodityId and p.TypeId = 4 and p.CountryId = @CountryId
			union
			select p.UserName, dbo.GetProfileValue(p.UserName, 'Name'), p.TypeId, p.CommodityId, p.CountryId, (@LaborWeight), p.ObjectId
			from [Wares].[dbo].[Percentages] p
			where p.CommodityId = @CommodityId and p.TypeId = 4 and p.CountryId <> @CountryId
			union
			select p.UserName, dbo.GetProfileValue(p.UserName, 'Name'), p.TypeId, p.CommodityId, p.CountryId, (@LandWeight * p.Percentage), p.ObjectId
			from [Wares].[dbo].[Percentages] p
			where p.CommodityId = @CommodityId and p.TypeId = 5 and p.CountryId = @CountryId
			union
			select p.UserName, dbo.GetProfileValue(p.UserName, 'Name'), p.TypeId, p.CommodityId, p.CountryId, (@LandWeight), p.ObjectId
			from [Wares].[dbo].[Percentages] p
			where p.CommodityId = @CommodityId and p.TypeId = 5 and p.CountryId <> @CountryId
	--select * from #result order by TypeId, WeightedPercentage DESC, ObjectId

	select ObjectId, UserName, NameName, CommodityId, SUM(ISNULL(WeightedPercentage, 0)) as WeightedPercentage
	from #result
	group by ObjectId, UserName, NameName, CommodityId
	order by WeightedPercentage DESC
END