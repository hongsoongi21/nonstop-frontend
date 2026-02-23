#!/bin/bash
# Run this script to ensure all universities have default boards
# Usage: ./apply_university_boards.sh

echo "Applying university boards migration..."
echo "This ensures all universities have communities and default boards."
echo ""

# Check if SUPABASE_DB_URL is set
if [ -z "$SUPABASE_DB_URL" ]; then
  echo "Error: SUPABASE_DB_URL environment variable is not set."
  echo "Set it to your Supabase PostgreSQL connection string:"
  echo "  export SUPABASE_DB_URL='postgresql://postgres:PASSWORD@HOST:5432/postgres'"
  echo ""
  echo "Or run via Supabase CLI:"
  echo "  supabase db push"
  exit 1
fi

psql "$SUPABASE_DB_URL" -f supabase/migrations/015_ensure_all_university_boards.sql

echo ""
echo "Done! All universities should now have default boards."
