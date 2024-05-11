CREATE TABLE local_collection_lite (
    [id] INTEGER NOT NULL PRIMARY KEY,
    [collectionName] TEXT NOT NULL,
    [collectionType] TEXT NOT NULL,
    [collectionMultiplicity] TEXT NOT NULL,
    [availabilityBasicEquipment] INTEGER NOT NULL,
    [genderName] TEXT NOT NULL
);
CREATE TABLE local_exercises_lite (
    [id] INTEGER NOT NULL PRIMARY KEY,
    [exerciseName] TEXT NOT NULL,
    [exerciseDescriptions] TEXT NULL,
    [muscleGroup] TEXT NOT NULL,
    [collectionServerId] INTEGER NULL,
    [exerciseCriteriaId] INTEGER NOT NULL
);

SELECT * FROM local_exercises_lite;