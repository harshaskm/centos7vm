CREATE TABLE wikipedia_editors (
  editor TEXT UNIQUE, -- The name of the editor
  bot BOOLEAN, -- Whether they are a bot (self-reported)

  edit_count INT, -- How many edits they've made
  added_chars INT, -- How many characters they've added
  removed_chars INT, -- How many characters they've removed

  first_seen TIMESTAMPTZ, -- The time we first saw them edit
  last_seen TIMESTAMPTZ -- The time we last saw them edit
)
;

CREATE TABLE wikipedia_changes (
  editor TEXT, -- The editor who made the change
  time TIMESTAMP WITH TIME ZONE, -- When they made it

  wiki TEXT, -- Which wiki they edited
  title TEXT, -- The name of the page they edited

  comment TEXT, -- The message they described the change with
  minor BOOLEAN, -- Whether this was a minor edit (self-reported)
  type TEXT, -- "new" if this created the page, "edit" otherwise

  old_length INT, -- how long the page used to be
  new_length INT -- how long the page is as of this edit
)
;


--These tables are regular Postgres tables. We need to tell Citus that they should be distributed tables, stored across the cluster.
SELECT master_create_distributed_table(
    'wikipedia_changes', 'editor', 'hash'
  )
;

SELECT master_create_distributed_table(
    'wikipedia_editors', 'editor', 'hash'
  )
;


--These say to store each table as a collection of shards, each responsible for holding a different subset of the data.
--  The shard a particular row belongs in will be computed by hashing the editor column.
-- Create the shards:

SELECT master_create_worker_shards('wikipedia_editors', 16, 1)
;
SELECT master_create_worker_shards('wikipedia_changes', 16, 1)
;


