Student Allocation Management Project

**Objective:** Efficiently allocate students to preferred subjects based on their preferences and academic performance.

**System Overview:** Maintains a table of subjects with the number of available seats for each.
Students submit preferences, indicating their top subject choices.
Records students' CGPA (Cumulative Grade Point Average) to factor into allocation decisions.

**Allocation Process:** A stored procedure sorts students by CGPA in descending order to prioritize higher academic performance.

**For each student:** Attempts to allocate their first preference if seats are available.
If the first preference is unavailable, the system progresses to subsequent preferences.
Updates the available seat count for each successful allocation.
Marks the student as "unallocated" if none of the preferences can be fulfilled.

**Final Outcome:** Allocated students are listed as "allocated," showing successful subject assignments.
Unallocated students are listed separately.

**Key Benefits:** Ensures fairness by considering both student preferences and academic performance.
Streamlines the allocation process using stored procedures for efficiency.
Enhances transparency and resource utilization.
Facilitates easier management and modification of the allocation process.
Demonstrates the effective use of technology to improve the student allocation experience.
