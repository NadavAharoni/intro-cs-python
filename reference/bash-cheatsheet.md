# דף עזר: פקודות הטרמינל

## מקומות מיוחדים

<div dir="rtl">

| סימן | משמעות |
|---|---|
| <code dir="ltr">~</code> | תיקיית הבית |
| <code dir="ltr">.</code> | התיקייה הנוכחית |
| <code dir="ltr">..</code> | התיקייה שמעל התיקייה הנוכחית |
| <code dir="ltr">/</code> | שורש מערכת הקבצים |
| <code dir="ltr">/c</code> | הכונן הראשי של חלונות |

</div>

## ניווט

<div dir="rtl">

| פקודה | מה היא עושה |
|---|---|
| <code dir="ltr">pwd</code> | מדפיסה את התיקייה הנוכחית |
| <code dir="ltr">ls</code> | מציגה את תוכן התיקייה |
| <code dir="ltr">ls -l</code> | תצוגה מפורטת |
| <code dir="ltr">ls -a</code> | כולל קבצים מוסתרים |
| <code dir="ltr">ls -R</code> | כולל כל התיקיות הפנימיות |
| <code dir="ltr">cd folder</code> | עוברת לתיקייה |
| <code dir="ltr">cd ..</code> | עולה תיקייה אחת למעלה |
| <code dir="ltr">cd ~</code> | חוזרת לתיקיית הבית |
| <code dir="ltr">cd -</code> | חוזרת לתיקייה הקודמת |

</div>

## קבצים ותיקיות

<div dir="rtl">

| פקודה | מה היא עושה |
|---|---|
| <code dir="ltr">mkdir name</code> | יוצרת תיקייה |
| <code dir="ltr">mkdir -p a/b/c</code> | יוצרת כמה רמות של תיקיות |
| <code dir="ltr">touch file.txt</code> | יוצרת קובץ ריק |
| <code dir="ltr">cp src dst</code> | מעתיקה קובץ |
| <code dir="ltr">cp -r src dst</code> | מעתיקה תיקייה |
| <code dir="ltr">mv src dst</code> | מעבירה או משנה שם |
| <code dir="ltr">rm file</code> | מוחקת קובץ, לצמיתות |
| <code dir="ltr">rmdir folder</code> | מוחקת תיקייה ריקה |
| <code dir="ltr">rm -r folder</code> | מוחקת תיקייה עם כל התוכן. זהירות! |

</div>

## תוכן של קבצים

<div dir="rtl">

| פקודה | מה היא עושה |
|---|---|
| <code dir="ltr">cat file</code> | מציגה את כל הקובץ |
| <code dir="ltr">head file</code> | מציגה את תחילת הקובץ |
| <code dir="ltr">tail file</code> | מציגה את סוף הקובץ |
| <code dir="ltr">wc -l file</code> | סופרת שורות |
| <code dir="ltr">grep text file</code> | מציגה שורות שמכילות טקסט |
| <code dir="ltr">echo "text" &gt; file</code> | כותבת לקובץ, ומוחקת את מה שהיה בו |
| <code dir="ltr">echo "text" &gt;&gt; file</code> | מוסיפה לסוף הקובץ |
| <code dir="ltr">a &#124; b</code> | מעבירה את הפלט של פקודה אחת לפקודה הבאה |

</div>

## כלים

<div dir="rtl">

| פקודה | מה היא עושה |
|---|---|
| <code dir="ltr">python file.py</code> | מריצה תוכנית פייתון |
| <code dir="ltr">python</code> | נכנסת למצב האינטראקטיבי של פייתון |
| <code dir="ltr">code .</code> | פותחת את התיקייה הנוכחית בעורך |
| <code dir="ltr">explorer .</code> | פותחת את התיקייה הנוכחית בסייר הקבצים |
| <code dir="ltr">clear</code> | מנקה את המסך |
| <code dir="ltr">history</code> | מציגה את הפקודות האחרונות |
| <code dir="ltr">command --help</code> | מציגה הסבר על פקודה |

</div>

## מקשים

<div dir="rtl">

| מקש | מה הוא עושה |
|---|---|
| <code dir="ltr">Tab</code> | משלים שם של קובץ או פקודה |
| <code dir="ltr">↑</code> | מחזיר את הפקודה הקודמת |
| <code dir="ltr">Ctrl+C</code> | עוצר פקודה או תוכנית שרצה |

</div>
