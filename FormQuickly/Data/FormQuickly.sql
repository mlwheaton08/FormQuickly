USE [master]
GO

IF db_id('FormQuickly') IS NULL
  CREATE DATABASE [FormQuickly]
GO

USE [FormQuickly]
GO

DROP TABLE IF EXISTS [UserNotification];
DROP TABLE IF EXISTS [NotificationType];
DROP TABLE IF EXISTS [PromptOptionPreset];
DROP TABLE IF EXISTS [FormPromptPreset];
DROP TABLE IF EXISTS [FormPreset];
DROP TABLE IF EXISTS [PromptOption];
DROP TABLE IF EXISTS [UserPromptAnswer];
DROP TABLE IF EXISTS [FormPrompt];
DROP TABLE IF EXISTS [UserClientForm];
DROP TABLE IF EXISTS [Form];
DROP TABLE IF EXISTS [User];

CREATE TABLE [User] (
  [Id] int PRIMARY KEY identity,
  [FirebaseId] nvarchar(255) unique not null,
  [Email] nvarchar(255) not null,
  [Username] nvarchar(255) not null,
  [DateRegistered] datetime not null
)
GO

CREATE TABLE [UserNotification] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [NotificationTypeId] int not null,
  [Text] nvarchar(255) not null,
  [Route] nvarchar(255) not null,
  [DateCreated] datetime not null,
  [Visited] bit not null
)
GO

CREATE TABLE [NotificationType] (
  [Id] int PRIMARY KEY identity,
  [Type] nvarchar(255) not null,
  [Image] nvarchar(255) not null
)
GO

CREATE TABLE [Form] (
  [Id] int PRIMARY KEY identity,
  [CreatorUserId] int not null,
  [Name] nvarchar(255) not null,
  [Description] nvarchar(2000),
  [UserResultsVisibility] nvarchar(255) not null,
  [AllResultsVisibility] nvarchar(255) not null,
  [MaxUserAttempts] int,
  [DateCreated] datetime not null,
  [DateEdited] datetime,
  [DateUpdated] datetime,
  [DateCompleted] datetime
)
GO

CREATE TABLE [FormPrompt] (
  [Id] int PRIMARY KEY identity,
  [FormId] int not null,
  [OrderPosition] int not null,
  [Type] nvarchar(255) not null,
  [Prompt] nvarchar(255),
  [InputDataType] nvarchar(255) not null,
  [ListStyle] nvarchar(255),
  [HasCorrectAnswer] bit not null,
  [CorrectAnswer] nvarchar(255),
  [UserResultsVisibility] nvarchar(255) not null,
  [AllResultsVisibility] nvarchar(255) not null,
  [AcceptSameUserAnswers] bit not null,
  [AllowUserAnswerEdit] bit not null,
  [MaxUserAttempts] int,
  [MaxSelectedSameOption] int,
  [MaxOptionsEachUserCanSelect] int
)
GO

CREATE TABLE [PromptOption] (
  [Id] int PRIMARY KEY identity,
  [PromptId] int not null,
  [OrderPosition] int not null,
  [Option] nvarchar(255) not null,
  [MaxTimesSelected] int
)
GO

CREATE TABLE [UserPromptAnswer] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [PromptId] int not null,
  [Answer] nvarchar(255) not null,
  [DateAnswered] datetime not null,
  [DateEdited] datetime
)
GO

CREATE TABLE [UserClientForm] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [FormId] int not null,
  [DateStarted] datetime,
  [DateUpdated] datetime,
  [DateCompleted] datetime
)
GO

CREATE TABLE [FormPreset] (
  [Id] int PRIMARY KEY identity,
  [Name] nvarchar(255) not null,
  [Description] nvarchar(255),
  [UserResultsVisibility] nvarchar(255) not null,
  [AllResultsVisibility] nvarchar(255) not null,
  [MaxUserAttempts] int
)
GO

CREATE TABLE [FormPromptPreset] (
  [Id] int PRIMARY KEY identity,
  [FormPresetId] int not null,
  [OrderPosition] int not null,
  [Type] nvarchar(255) not null,
  [Prompt] nvarchar(255),
  [InputDataType] nvarchar(255) not null,
  [ListStyle] nvarchar(255),
  [HasCorrectAnswer] bit not null,
  [CorrectAnswer] nvarchar(255),
  [UserResultsVisibility] nvarchar(255) not null,
  [AllResultsVisibility] nvarchar(255) not null,
  [AcceptSameUserAnswers] bit not null,
  [AllowUserAnswerEdit] bit not null,
  [MaxUserAttempts] int,
  [MaxSelectedSameOption] int,
  [MaxOptionsEachUserCanSelect] int
)
GO

CREATE TABLE [PromptOptionPreset] (
  [Id] int PRIMARY KEY identity,
  [PresetPromptId] int not null,
  [OrderPosition] int not null,
  [Option] nvarchar(255) not null,
  [MaxTimesSelected] int
)
GO

ALTER TABLE [Form] ADD FOREIGN KEY ([CreatorUserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [FormPrompt] ADD FOREIGN KEY ([FormId]) REFERENCES [Form] ([Id])
GO

ALTER TABLE [PromptOption] ADD FOREIGN KEY ([PromptId]) REFERENCES [FormPrompt] ([Id])
GO

ALTER TABLE [UserPromptAnswer] ADD FOREIGN KEY ([UserId]) REFERENCES [Form] ([Id])
GO

ALTER TABLE [UserPromptAnswer] ADD FOREIGN KEY ([PromptId]) REFERENCES [FormPrompt] ([Id])
GO

ALTER TABLE [UserNotification] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [UserNotification] ADD FOREIGN KEY ([NotificationTypeId]) REFERENCES [NotificationType] ([Id])
GO

ALTER TABLE [UserClientForm] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [UserClientForm] ADD FOREIGN KEY ([FormId]) REFERENCES [Form] ([Id])
GO

ALTER TABLE [FormPromptPreset] ADD FOREIGN KEY ([FormPresetId]) REFERENCES [FormPreset] ([Id])
GO

ALTER TABLE [PromptOptionPreset] ADD FOREIGN KEY ([PresetPromptId]) REFERENCES [FormPromptPreset] ([Id])
GO


-- STARTING DATA

INSERT INTO [User] (FirebaseId,Email,Username,DateRegistered)
VALUES
  ('aaaaa','serenaburton@icloud.org','sBurton','2024-06-18T10:47:20.000Z'),
  ('bbbbb','hasadwelch@outlook.ca','hWelch','2024-02-21T06:55:46.000Z'),
  ('ccccc','iladawson5963@aol.org','iDawson','2024-04-14T10:30:20.000Z'),
  ('ddddd','quinncole5977@aol.couk','qCole','2023-10-10T04:01:55.000Z'),
  ('eeeee','anjoliehart@protonmail.net','aHart','2024-03-06T05:16:27.000Z');
GO

INSERT INTO Form (CreatorUserId,
					[Name],
					[Description],
					UserResultsVisibility,
					AllResultsVisibility,
					MaxUserAttempts,
					DateCreated,
					DateEdited,
					DateUpdated,
					DateCompleted)
VALUES
	(1,
	'History Pop Quiz',
	'Take your time answering these questions. You may have 2 attempts',
	'visible',
	'hidden',
	2,
	'2023-07-06T05:44:32.000Z',
	'2023-07-07T09:22:14.000Z',
	'2023-07-08T01:23:32.000Z',
	'2023-07-08T01:23:32.000Z'),

	(1,
	'Quiz: Get to know Mrs. Burton',
	null,
	'visible',
	'visible',
	1,
	'2023-02-04T05:44:32.000Z',
	'2023-02-05T09:22:14.000Z',
	'2023-02-06T01:23:32.000Z',
	'2023-02-06T01:23:32.000Z'),

	(1,
	'What type of learner are you?',
	'Answer quickly without putting too much thought into it. Options range from "Strongly agree" to "Strongly disagree".',
	'hidden',
	'hidden',
	1,
	'2023-03-01T05:44:32.000Z',
	'2023-03-02T09:22:14.000Z',
	'2023-03-03T01:23:32.000Z',
	'2023-03-03T01:23:32.000Z'),

	(3,
	'Tell me what you''re bringing to my party this Saturday',
	null,
	'visible',
	'visible',
	null,
	'2022-08-11T05:44:32.000Z',
	'2022-08-12T09:22:14.000Z',
	'2022-08-14T01:23:32.000Z',
	'2022-08-14T01:23:32.000Z'),

	(3,
	'D&D character backstory',
	'Please complete this by Wednesday so I can write your character into the campaign and prepare an intro for them. Thanks!',
	'visible',
	'hidden',
	null,
	'2022-03-18T05:44:32.000Z',
	'2022-03-19T09:22:14.000Z',
	'2022-03-21T01:23:32.000Z',
	'2022-03-21T01:23:32.000Z'),

	(5,
	'About Me Questionnaire',
	'Let us get to know you! Please complete this form before our first meetup next month. Thanks!',
	'visible',
	'hidden',
	null,
	'2021-05-13T05:44:32.000Z',
	'2021-05-14T09:22:14.000Z',
	'2021-05-15T01:23:32.000Z',
	'2021-05-15T01:23:32.000Z')
GO