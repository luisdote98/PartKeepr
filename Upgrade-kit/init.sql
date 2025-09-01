USE partkeepr;

-- Add admin field (if it doesn't exist)
ALTER TABLE PartKeeprUser
ADD COLUMN IF NOT EXISTS admin TINYINT(1) DEFAULT 0;

-- Add permissions for components
ALTER TABLE PartKeeprUser
ADD COLUMN IF NOT EXISTS canCreateComponents TINYINT(1) DEFAULT 0,
ADD COLUMN IF NOT EXISTS canDeleteComponents TINYINT(1) DEFAULT 0;

-- Add phone number
ALTER TABLE PartKeeprUser
ADD COLUMN IF NOT EXISTS phoneNumber VARCHAR(20) NULL;

-- Add route to profile photo
ALTER TABLE PartKeeprUser
ADD COLUMN IF NOT EXISTS photo VARCHAR(255) NULL;

-- Set a user as admin
UPDATE PartKeeprUser SET admin = 1, canCreateComponents = 1, canDeleteComponents = 1 WHERE username = 'admin';

