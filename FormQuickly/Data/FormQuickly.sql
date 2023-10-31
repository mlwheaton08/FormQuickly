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
  [RegisterDate] datetime not null
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
  [ListStyle] nvarchar(255),
  [PromptsHaveCorrectAnswers] bit not null,
  [FormVisibility] nvarchar(255) not null,
  [UserAnswerVisibility] nvarchar(255) not null,
  [MaxUserAttempts] int,
  [MaxSelectedSamePromptOption] int,
  [MaxOptionsEachUserCanSelect] int,
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
  [UserAnswerVisibility] nvarchar(255) not null,
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
  [ListStyle] nvarchar(255),
  [PromptsHaveCorrectAnswers] bit not null,
  [FormVisibility] nvarchar(255) not null,
  [UserAnswerVisibility] nvarchar(255) not null,
  [MaxUserAttempts] int,
  [MaxSelectedSamePromptOption] int,
  [MaxOptionsEachUserCanSelect] int
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
  [UserAnswerVisibility] nvarchar(255) not null,
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