-- Car Rental Portal feature migration. Run against an existing car_rental database.
CREATE TABLE IF NOT EXISTS support_queries (
 query_id SERIAL PRIMARY KEY,
 user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
 subject VARCHAR(120) NOT NULL,
 message VARCHAR(3000) NOT NULL,
 admin_reply TEXT,
 status VARCHAR(20) NOT NULL DEFAULT 'Open' CHECK (status IN ('Open','In Progress','Answered','Closed')),
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 replied_at TIMESTAMP
);
CREATE INDEX IF NOT EXISTS idx_support_queries_user ON support_queries(user_id, created_at DESC);

ALTER TABLE cars ADD COLUMN IF NOT EXISTS image_data BYTEA;
ALTER TABLE cars ADD COLUMN IF NOT EXISTS image_content_type VARCHAR(50);
