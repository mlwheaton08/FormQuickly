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
  [Id] int PRIMARY KEY,
  [FirebaseId] nvarchar(255),
  [Email] nvarchar(255),
  [Username] nvarchar(255),
  [RegisterDate] datetime
)
GO

CREATE TABLE [UserNotification] (
  [Id] int PRIMARY KEY,
  [UserId] int,
  [NotificationTypeId] int,
  [Text] nvarchar(255),
  [Route] nvarchar(255),
  [DateCreated] datetime,
  [Visited] bit
)
GO

CREATE TABLE [NotificationType] (
  [Id] int PRIMARY KEY,
  [Type] nvarchar(255),
  [Image] nvarchar(255)
)
GO

CREATE TABLE [Form] (
  [Id] int PRIMARY KEY,
  [CreatorUserId] int,
  [Name] nvarchar(255),
  [Description] nvarchar(255),
  [ListStyle] nvarchar(255),
  [PromptsHaveCorrectAnswers] bit,
  [FormVisibility] nvarchar(255),
  [UserAnswerVisibility] nvarchar(255),
  [MaxUserAttempts] int,
  [MaxSelectedSamePromptOption] int,
  [MaxOptionsEachUserCanSelect] int,
  [DateCreated] datetime,
  [DateEdited] datetime,
  [DateUpdated] datetime,
  [DateCompleted] datetime
)
GO

CREATE TABLE [FormPrompt] (
  [Id] int PRIMARY KEY,
  [FormId] int,
  [OrderPosition] int,
  [Type] nvarchar(255),
  [Prompt] nvarchar(255),
  [InputDataType] nvarchar(255),
  [ListStyle] nvarchar(255),
  [HasCorrectAnswer] bit,
  [CorrectAnswer] nvarchar(255),
  [UserAnswerVisibility] nvarchar(255),
  [AcceptSameUserAnswers] bit,
  [AllowUserAnswerEdit] bit,
  [MaxUserAttempts] int,
  [MaxSelectedSameOption] int,
  [MaxOptionsEachUserCanSelect] int
)
GO

CREATE TABLE [PromptOption] (
  [Id] int PRIMARY KEY,
  [PromptId] int,
  [OrderPosition] int,
  [Option] nvarchar(255),
  [MaxTimesSelected] int
)
GO

CREATE TABLE [UserPromptAnswer] (
  [Id] int PRIMARY KEY,
  [UserId] int,
  [PromptId] int,
  [Answer] nvarchar(255),
  [DateAnswered] datetime,
  [DateEdited] datetime
)
GO

CREATE TABLE [UserClientForm] (
  [Id] int PRIMARY KEY,
  [UserId] int,
  [FormId] int,
  [DateStarted] datetime,
  [DateUpdated] datetime,
  [DateCompleted] datetime
)
GO

CREATE TABLE [FormPreset] (
  [Id] int PRIMARY KEY,
  [Name] nvarchar(255),
  [Description] nvarchar(255),
  [ListStyle] nvarchar(255),
  [PromptsHaveCorrectAnswers] bit,
  [FormVisibility] nvarchar(255),
  [UserAnswerVisibility] nvarchar(255),
  [MaxUserAttempts] int,
  [MaxSelectedSamePromptOption] int,
  [MaxOptionsEachUserCanSelect] int
)
GO

CREATE TABLE [FormPromptPreset] (
  [Id] int PRIMARY KEY,
  [FormPresetId] int,
  [OrderPosition] int,
  [Type] nvarchar(255),
  [Prompt] nvarchar(255),
  [InputDataType] nvarchar(255),
  [ListStyle] nvarchar(255),
  [HasCorrectAnswer] bit,
  [CorrectAnswer] nvarchar(255),
  [UserAnswerVisibility] nvarchar(255),
  [AcceptSameUserAnswers] bit,
  [AllowUserAnswerEdit] bit,
  [MaxUserAttempts] int,
  [MaxSelectedSameOption] int,
  [MaxOptionsEachUserCanSelect] int
)
GO

CREATE TABLE [PromptOptionPreset] (
  [Id] int PRIMARY KEY,
  [PresetPromptId] int,
  [OrderPosition] int,
  [Option] nvarchar(255),
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
