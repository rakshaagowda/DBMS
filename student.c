#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Student {
    int SID;
    char NAME[30];
    char BRANCH[10];
    int SEMESTER;
    char ADDRESS[50];
};


void insertStudent() {
    struct Student s;
    FILE *fp = fopen("student.dat", "ab");

    printf("Enter SID: ");
    scanf("%d", &s.SID);
    getchar();

    printf("Enter Name: ");
    gets(s.NAME);

    printf("Enter Branch: ");
    gets(s.BRANCH);

    printf("Enter Semester: ");
    scanf("%d", &s.SEMESTER);
    getchar();

    printf("Enter Address: ");
    gets(s.ADDRESS);

    fwrite(&s, sizeof(s), 1, fp);
    fclose(fp);

    printf("Student inserted successfully\n");
}


void modifyAddress() {
    struct Student s;
    int sid;
    FILE *fp = fopen("student.dat", "rb+");

    printf("Enter SID to modify address: ");
    scanf("%d", &sid);
    getchar();

    while (fread(&s, sizeof(s), 1, fp)) {
        if (s.SID == sid) {
            printf("Enter new address: ");
            gets(s.ADDRESS);
            fseek(fp, -sizeof(s), SEEK_CUR);
            fwrite(&s, sizeof(s), 1, fp);
            printf("Address updated successfully\n");
            fclose(fp);
            return;
        }
    }

    printf("Student not found\n");
    fclose(fp);
}

/* c. Delete a student */
void deleteStudent() {
    struct Student s;
    int sid;
    FILE *fp = fopen("student.dat", "rb");
    FILE *temp = fopen("temp.dat", "wb");

    printf("Enter SID to delete: ");
    scanf("%d", &sid);

    while (fread(&s, sizeof(s), 1, fp)) {
        if (s.SID != sid)
            fwrite(&s, sizeof(s), 1, temp);
    }

    fclose(fp);
    fclose(temp);

    remove("student.dat");
    rename("temp.dat", "student.dat");

    printf("Student deleted successfully\n");
}

/* d. List all students */
void listAll() {
    struct Student s;
    FILE *fp = fopen("student.dat", "rb");

    printf("\nAll Students:\n");
    while (fread(&s, sizeof(s), 1, fp)) {
        printf("%d | %s | %s | %d | %s\n",
               s.SID, s.NAME, s.BRANCH, s.SEMESTER, s.ADDRESS);
    }
    fclose(fp);
}


void listCSE() {
    struct Student s;
    FILE *fp = fopen("student.dat", "rb");

    printf("\nCSE Students:\n");
    while (fread(&s, sizeof(s), 1, fp)) {
        if (strcmp(s.BRANCH, "CSE") == 0) {
            printf("%d | %s | %d | %s\n",
                   s.SID, s.NAME, s.SEMESTER, s.ADDRESS);
        }
    }
    fclose(fp);
}


void listCSEKuvempunagar() {
    struct Student s;
    FILE *fp = fopen("student.dat", "rb");

    printf("\nCSE Students from Kuvempunagar:\n");
    while (fread(&s, sizeof(s), 1, fp)) {
        if (strcmp(s.BRANCH, "CSE") == 0 &&
            strcmp(s.ADDRESS, "Kuvempunagar") == 0) {
            printf("%d | %s | %d\n",
                   s.SID, s.NAME, s.SEMESTER);
        }
    }
    fclose(fp);
}

int main() {
    int choice;
    do {
        printf("\n--- Student File Menu ---\n");
        printf("1. Insert Student\n");
        printf("2. Modify Address\n");
        printf("3. Delete Student\n");
        printf("4. List All Students\n");
        printf("5. List CSE Students\n");
        printf("6. List CSE Students from Kuvempunagar\n");
        printf("7. Exit\n");
        printf("Enter choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1: insertStudent(); break;
            case 2: modifyAddress(); break;
            case 3: deleteStudent(); break;
            case 4: listAll(); break;
            case 5: listCSE(); break;
            case 6: listCSEKuvempunagar(); break;
            case 7: printf("Exiting...\n"); break;
            default: printf("Invalid choice\n");
        }
    } while (choice != 7);

    return 0;
}
