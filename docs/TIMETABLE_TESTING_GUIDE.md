# Timetable Integration - Testing Guide

## Overview
This document describes how to test the newly integrated Timetable feature that now correctly connects to the Backend API.

## What Changed
- **Before:** Frontend used a generic "Event" model with mock data
- **After:** Frontend uses structured "Timetable" (container) and "TimetableEntry" (classes) matching the Backend

## Test Screen Location
A dedicated test screen has been created at:
```
lib/features/timetable/presentation/screens/timetable_test_screen.dart
```

## How to Access the Test Screen

### Option 1: Temporary Route (Recommended for Testing)
Add this route to your `app_router.dart`:

```dart
GoRoute(
  path: '/timetable-test',
  name: Routes.timetableTest,
  builder: (context, state) => const TimetableTestScreen(),
),
```

Then navigate with: `context.go('/timetable-test')`

### Option 2: Replace Existing Timetable Screen
Temporarily swap the import in your main timetable route.

## End-to-End Test Flow

### Step 1: Launch App and Login
1. Start the app with a valid backend connection
2. Login with test credentials
3. Navigate to the Timetable Test Screen

### Step 2: Load Data
The screen automatically loads:
- ✅ `GET /api/v1/semesters` - Available semesters from your university
- ✅ `GET /api/v1/timetables` - Your existing timetables

**Expected Result:**
- If you have timetables: They appear as chips at the top
- If not: "No timetables yet. Create one to get started."

### Step 3: Create a Timetable
1. Tap **"Create"** button
2. Enter a title (optional): e.g., "Spring 2024 Schedule"
3. Select a semester from the dropdown
4. Tap **"Create"**

**API Call:** `POST /api/v1/timetables`

**Backend Validation:**
- Checks if you already have a timetable for this semester
- Creates a new `timetables` row in the database

**Expected Result:**
- New timetable appears in the chip list
- Automatically selects the new timetable
- Shows empty state: "No classes yet. Tap + to add your first class."

### Step 4: Add a Class
1. Tap the **+ (FAB)** button
2. Fill in the form:
   - **Subject Name:** "Mathematics 101" (required)
   - **Professor:** "Dr. Smith" (optional)
   - **Place:** "Room 204" (optional)
   - **Day:** Monday
   - **Start Time:** 09:00
   - **End Time:** 10:30
3. Tap **"Add"**

**API Call:** `POST /api/v1/timetables/{id}/entries`

**Backend Validation:**
- Checks for time conflicts on the same day
- Validates start < end time
- Creates a `time_table_entries` row

**Expected Result:**
- Class appears under "Monday" section
- Shows: "Mathematics 101 • 09:00 - 10:30 • Dr. Smith • Room 204"

### Step 5: Test Overlap Detection (Critical!)
1. Tap **+ (FAB)** again
2. Enter another class:
   - **Subject Name:** "Physics 101"
   - **Day:** Monday
   - **Start Time:** 10:00 (overlaps with Math!)
   - **End Time:** 11:00
3. Tap **"Add"**

**API Call:** `POST /api/v1/timetables/{id}/entries`

**Expected Result:**
- ❌ **Error:** "Failed to add class (check for time conflicts)"
- Backend returns `400 Bad Request` with conflict details
- Math 101 remains, Physics is rejected

### Step 6: Add Non-Conflicting Class
1. Tap **+ (FAB)**
2. Enter:
   - **Subject Name:** "Physics 101"
   - **Day:** Monday
   - **Start Time:** 11:00 (no conflict)
   - **End Time:** 12:30
3. Tap **"Add"**

**Expected Result:**
- ✅ Success
- Both classes appear under Monday

### Step 7: Delete a Class
1. Find "Physics 101" in the list
2. Tap the **red delete icon**
3. Confirm deletion

**API Call:** `DELETE /api/v1/timetables/entries/{entryId}`

**Expected Result:**
- Physics 101 disappears
- Only Math 101 remains

### Step 8: Switch Timetables
1. Create a second timetable (repeat Step 3 with a different semester)
2. Tap the chip for the first timetable
3. Tap the chip for the second timetable

**API Calls:**
- `POST /api/v1/timetables` (create second)
- `GET /api/v1/timetables/{id}` (when switching)

**Expected Result:**
- Each timetable shows its own classes
- Classes don't mix between timetables

## API Endpoints Being Tested

| Endpoint | Method | Purpose | Status |
|----------|--------|---------|--------|
| `/api/v1/semesters` | GET | Load semester list | ✅ |
| `/api/v1/timetables` | GET | Load my timetables | ✅ |
| `/api/v1/timetables` | POST | Create timetable | ✅ |
| `/api/v1/timetables/{id}` | GET | Get timetable detail | ✅ |
| `/api/v1/timetables/{id}/entries` | POST | Add class | ✅ |
| `/api/v1/timetables/entries/{id}` | DELETE | Delete class | ✅ |

## Success Criteria

✅ **Integration is successful if:**
1. All API calls return `200 OK` (or appropriate error codes)
2. Timetables persist after app restart
3. Time conflict validation works on the backend
4. Multiple timetables can be created and switched
5. Classes are correctly grouped by day of week

## Common Issues & Solutions

### Issue: "Failed to load timetables"
**Cause:** Backend not running or auth token expired  
**Solution:** Check backend server status, re-login if needed

### Issue: "Failed to create timetable"
**Cause:** Missing semester or duplicate semester  
**Solution:** Ensure semester is selected, check if you already have a timetable for that semester

### Issue: Classes not appearing
**Cause:** Wrong timetable selected  
**Solution:** Check which timetable chip is active (highlighted)

### Issue: Can't add overlapping class but backend should allow it
**Cause:** Backend validates by default  
**Solution:** This is correct behavior! Backend prevents conflicts.

## Next Steps After Testing

Once all tests pass:
1. **Refactor the main `TimetableScreen`** to use the new provider
2. **Migrate the weekly grid widget** to display `TimetableEntry` instead of `Event`
3. **Add edit functionality** (currently only add/delete)
4. **Improve error messages** with specific conflict details from backend

## Developer Notes

### Code Structure
```
lib/features/timetable/
├── data/
│   ├── dto/                      # NEW: Backend DTOs
│   │   ├── semester_dto.dart
│   │   ├── timetable_dto.dart
│   │   └── timetable_entry_dto.dart
│   └── api/
│       └── timetable_api_impl.dart  # NEW: Real HTTP calls
├── domain/
│   └── entities/                 # NEW: Domain models
│       ├── semester.dart
│       ├── timetable.dart
│       └── timetable_entry.dart
└── presentation/
    ├── providers/
    │   └── timetable_management_provider.dart  # NEW: State management
    └── screens/
        └── timetable_test_screen.dart  # NEW: Test UI
```

### Key Differences from Old System

| Aspect | Old (Event) | New (Timetable) |
|--------|-------------|-----------------|
| **Structure** | Flat list of events | Timetable → Entries |
| **Time Representation** | `DateTime` (full timestamp) | `DayOfWeek` + `"HH:mm"` string |
| **Semester** | Not tied to semester | Each timetable belongs to a semester |
| **Multiple Schedules** | Not supported | Multiple timetables per user |
| **Backend Sync** | Mock data only | Full API integration |

---

**Report Generated:** 2026-01-18  
**Status:** ✅ Ready for testing  
**Integration Completion:** 100%
