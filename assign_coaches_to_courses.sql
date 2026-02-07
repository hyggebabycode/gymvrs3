    -- Script to assign coaches to existing courses that don't have one
    -- This ensures all courses have a coach/trainer assigned

    -- First, check which courses don't have a coach
    SELECT id, course_name, coach_id 
    FROM courses 
    WHERE coach_id IS NULL;

    -- Option 1: Manually assign specific coaches to specific courses
    -- Replace 'COURSE_ID' and 'COACH_ID' with actual UUIDs from your database
    /*
    UPDATE courses 
    SET coach_id = 'COACH_ID'
    WHERE id = 'COURSE_ID';
    */

    -- Option 2: Automatically distribute courses among available coaches
    -- This will assign coaches to courses in a round-robin fashion
    /*
    WITH coaches_list AS (
    SELECT id, full_name, ROW_NUMBER() OVER (ORDER BY created_at) as coach_order
    FROM users 
    WHERE role = 'coach'
    ),
    courses_without_coach AS (
    SELECT id, ROW_NUMBER() OVER (ORDER BY created_at) as course_order
    FROM courses 
    WHERE coach_id IS NULL
    )
    UPDATE courses
    SET coach_id = (
    SELECT coaches_list.id 
    FROM coaches_list 
    WHERE coaches_list.coach_order = ((courses_without_coach.course_order - 1) % (SELECT COUNT(*) FROM coaches_list)) + 1
    )
    FROM courses_without_coach
    WHERE courses.id = courses_without_coach.id;
    */

    -- Option 3: Assign all courses without coach to a default coach (first coach in database)
    -- Uncomment and run this if you want to quickly assign all to one coach
    /*
    UPDATE courses 
    SET coach_id = (
    SELECT id FROM users WHERE role = 'coach' ORDER BY created_at LIMIT 1
    )
    WHERE coach_id IS NULL;
    */

    -- After assigning coaches, verify the results:
    -- SELECT c.id, c.course_name, u.full_name as coach_name
    -- FROM courses c
    -- LEFT JOIN users u ON c.coach_id = u.id;

    -- ============================================
    -- RECOMMENDED STEPS:
    -- ============================================
    -- 1. Run the first SELECT query to see courses without coaches
    -- 2. Choose ONE of the three options above (uncomment it)
    -- 3. Run the chosen UPDATE query
    -- 4. Verify results with the final SELECT query
    -- 5. In the admin dashboard, you can now see and change coaches for each course

    -- ============================================
    -- Example for your 3 coaches:
    -- ============================================
    -- Assuming you have coaches:
    -- - hungtran winer (coachhung@gymheart.com)
    -- - mua dong bang gia (coach@gymheart.com)  
    -- - tran van hung1 (admin4@gymheart.com)

    -- You can manually assign like this:
    /*
    -- Get coach IDs first
    SELECT id, full_name, email FROM users WHERE role = 'coach';

    -- Then assign to specific courses
    UPDATE courses SET coach_id = 'COACH_UUID_1' WHERE course_name = 'Yoga Cơ Bản';
    UPDATE courses SET coach_id = 'COACH_UUID_2' WHERE course_name = 'Gym Tăng Cơ';
    UPDATE courses SET coach_id = 'COACH_UUID_3' WHERE course_name = 'Cardio Giảm Cân';
    */
