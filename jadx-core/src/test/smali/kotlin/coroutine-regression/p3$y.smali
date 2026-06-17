.class public abstract Lp3/y;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final a:Lu0/t;

.field public static final b:Lu0/t;

.field public static final c:Lu0/t;

.field public static final d:Lu0/t;

.field public static final e:Lu0/t;

.field public static final f:Lu0/t;

.field public static final g:Lu0/t;

.field public static final h:Lu0/t;

.field public static final i:Lp3/g0;

.field public static final j:Lp3/g0;


# direct methods
.method static synthetic constructor <clinit>()V
    .registers 3

    new-instance v0, Lu0/t;

    const-string v1, "RESUME_TOKEN"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->a:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "REMOVED_TASK"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->b:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "CLOSED_EMPTY"

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->c:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "COMPLETING_ALREADY"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->d:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "COMPLETING_WAITING_CHILDREN"

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->e:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "COMPLETING_RETRY"

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->f:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "TOO_LATE_TO_CANCEL"

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->g:Lu0/t;

    new-instance v0, Lu0/t;

    const-string v1, "SEALED"

    invoke-direct {v0, v1, v2}, Lu0/t;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lp3/y;->h:Lu0/t;

    new-instance v0, Lp3/g0;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lp3/g0;-><init>(Z)V

    sput-object v0, Lp3/y;->i:Lp3/g0;

    new-instance v0, Lp3/g0;

    invoke-direct {v0, v2}, Lp3/g0;-><init>(Z)V

    sput-object v0, Lp3/y;->j:Lp3/g0;

    return-void
.end method

.method public static A(Landroid/content/Context;Landroid/net/Uri;)Ljava/nio/MappedByteBuffer;
    .registers 10

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    const/4 v0, 0x0

    :try_start_5
    const-string v1, "r"

    invoke-virtual {p0, p1, v1, v0}, Landroid/content/ContentResolver;->openFileDescriptor(Landroid/net/Uri;Ljava/lang/String;Landroid/os/CancellationSignal;)Landroid/os/ParcelFileDescriptor;

    move-result-object p0

    if-nez p0, :cond_13

    if-eqz p0, :cond_12

    invoke-virtual {p0}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_12} :catch_48

    :cond_12
    return-object v0

    :cond_13
    :try_start_13
    new-instance p1, Ljava/io/FileInputStream;

    invoke-virtual {p0}, Landroid/os/ParcelFileDescriptor;->getFileDescriptor()Ljava/io/FileDescriptor;

    move-result-object v1

    invoke-direct {p1, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/FileDescriptor;)V
    :try_end_1c
    .catchall {:try_start_13 .. :try_end_1c} :catchall_33

    :try_start_1c
    invoke-virtual {p1}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/channels/FileChannel;->size()J

    move-result-wide v6

    sget-object v3, Ljava/nio/channels/FileChannel$MapMode;->READ_ONLY:Ljava/nio/channels/FileChannel$MapMode;

    const-wide/16 v4, 0x0

    invoke-virtual/range {v2 .. v7}, Ljava/nio/channels/FileChannel;->map(Ljava/nio/channels/FileChannel$MapMode;JJ)Ljava/nio/MappedByteBuffer;

    move-result-object v1
    :try_end_2c
    .catchall {:try_start_1c .. :try_end_2c} :catchall_35

    :try_start_2c
    invoke-virtual {p1}, Ljava/io/FileInputStream;->close()V
    :try_end_2f
    .catchall {:try_start_2c .. :try_end_2f} :catchall_33

    :try_start_2f
    invoke-virtual {p0}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_32
    .catch Ljava/io/IOException; {:try_start_2f .. :try_end_32} :catch_48

    return-object v1

    :catchall_33
    move-exception p1

    goto :goto_3f

    :catchall_35
    move-exception v1

    :try_start_36
    invoke-virtual {p1}, Ljava/io/FileInputStream;->close()V
    :try_end_39
    .catchall {:try_start_36 .. :try_end_39} :catchall_3a

    goto :goto_3e

    :catchall_3a
    move-exception p1

    :try_start_3b
    invoke-virtual {v1, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_3e
    throw v1
    :try_end_3f
    .catchall {:try_start_3b .. :try_end_3f} :catchall_33

    :goto_3f
    :try_start_3f
    invoke-virtual {p0}, Landroid/os/ParcelFileDescriptor;->close()V
    :try_end_42
    .catchall {:try_start_3f .. :try_end_42} :catchall_43

    goto :goto_47

    :catchall_43
    move-exception p0

    :try_start_44
    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_47
    throw p1
    :try_end_48
    .catch Ljava/io/IOException; {:try_start_44 .. :try_end_48} :catch_48

    :catch_48
    return-object v0
.end method

.method public static B(Landroid/content/res/Resources;Landroid/content/res/Resources$Theme;Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;
    .registers 4

    if-nez p1, :cond_7

    invoke-virtual {p0, p2, p3}, Landroid/content/res/Resources;->obtainAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object p0

    return-object p0

    :cond_7
    const/4 p0, 0x0

    invoke-virtual {p1, p2, p3, p0, p0}, Landroid/content/res/Resources$Theme;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object p0

    return-object p0
.end method

.method public static C(Landroid/view/View;Landroid/view/inputmethod/EditorInfo;Landroid/view/inputmethod/InputConnection;)V
    .registers 3

    if-eqz p2, :cond_13

    iget-object p1, p1, Landroid/view/inputmethod/EditorInfo;->hintText:Ljava/lang/CharSequence;

    if-nez p1, :cond_13

    invoke-virtual {p0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object p0

    :goto_a
    instance-of p1, p0, Landroid/view/View;

    if-eqz p1, :cond_13

    invoke-interface {p0}, Landroid/view/ViewParent;->getParent()Landroid/view/ViewParent;

    move-result-object p0

    goto :goto_a

    :cond_13
    return-void
.end method

.method public static D(Landroid/content/res/XmlResourceParser;Landroid/content/res/Resources;)Lb0/e;
    .registers 25

    move-object/from16 v0, p1

    :goto_2
    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x2

    if-eq v1, v3, :cond_d

    if-eq v1, v2, :cond_d

    goto :goto_2

    :cond_d
    if-ne v1, v3, :cond_121

    const/4 v1, 0x0

    const-string v4, "font-family"

    move-object/from16 v5, p0

    invoke-interface {v5, v3, v1, v4}, Lorg/xmlpull/v1/XmlPullParser;->require(ILjava/lang/String;Ljava/lang/String;)V

    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v6, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_11c

    invoke-static/range {p0 .. p0}, Landroid/util/Xml;->asAttributeSet(Lorg/xmlpull/v1/XmlPullParser;)Landroid/util/AttributeSet;

    move-result-object v4

    sget-object v6, Ly/a;->b:[I

    invoke-virtual {v0, v4, v6}, Landroid/content/res/Resources;->obtainAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v4

    const/4 v6, 0x0

    invoke-virtual {v4, v6}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x4

    invoke-virtual {v4, v8}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v9

    const/4 v10, 0x5

    invoke-virtual {v4, v10}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v4, v2, v6}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v12

    invoke-virtual {v4, v3, v2}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v13

    const/4 v14, 0x3

    const/16 v15, 0x1f4

    invoke-virtual {v4, v14, v15}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v15

    const/4 v1, 0x6

    invoke-virtual {v4, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4}, Landroid/content/res/TypedArray;->recycle()V

    if-eqz v7, :cond_71

    if-eqz v9, :cond_71

    if-eqz v11, :cond_71

    :goto_57
    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v1

    if-eq v1, v14, :cond_61

    invoke-static/range {p0 .. p0}, Lp3/y;->H(Landroid/content/res/XmlResourceParser;)V

    goto :goto_57

    :cond_61
    invoke-static {v12, v0}, Lp3/y;->F(ILandroid/content/res/Resources;)Ljava/util/List;

    move-result-object v0

    new-instance v1, Lb0/h;

    new-instance v2, Lk/s;

    invoke-direct {v2, v7, v9, v11, v0}, Lk/s;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V

    invoke-direct {v1, v2, v13, v15, v8}, Lb0/h;-><init>(Lk/s;IILjava/lang/String;)V

    goto/16 :goto_120

    :cond_71
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    :goto_76
    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v7

    if-eq v7, v14, :cond_107

    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->getEventType()I

    move-result v7

    if-eq v7, v3, :cond_83

    goto :goto_76

    :cond_83
    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v7

    const-string v8, "font"

    invoke-virtual {v7, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v7

    if-eqz v7, :cond_102

    invoke-static/range {p0 .. p0}, Landroid/util/Xml;->asAttributeSet(Lorg/xmlpull/v1/XmlPullParser;)Landroid/util/AttributeSet;

    move-result-object v7

    sget-object v8, Ly/a;->c:[I

    invoke-virtual {v0, v7, v8}, Landroid/content/res/Resources;->obtainAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v7

    const/16 v8, 0x8

    invoke-virtual {v7, v8}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v9

    if-eqz v9, :cond_a2

    goto :goto_a3

    :cond_a2
    move v8, v2

    :goto_a3
    const/16 v9, 0x190

    invoke-virtual {v7, v8, v9}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v17

    invoke-virtual {v7, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v8

    if-eqz v8, :cond_b1

    move v8, v1

    goto :goto_b2

    :cond_b1
    move v8, v3

    :goto_b2
    invoke-virtual {v7, v8, v6}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v8

    if-ne v2, v8, :cond_bb

    move/from16 v22, v2

    goto :goto_bd

    :cond_bb
    move/from16 v22, v6

    :goto_bd
    const/16 v8, 0x9

    invoke-virtual {v7, v8}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v9

    if-eqz v9, :cond_c6

    goto :goto_c7

    :cond_c6
    move v8, v14

    :goto_c7
    const/4 v9, 0x7

    invoke-virtual {v7, v9}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v11

    if-eqz v11, :cond_cf

    goto :goto_d0

    :cond_cf
    const/4 v9, 0x4

    :goto_d0
    invoke-virtual {v7, v9}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v21

    invoke-virtual {v7, v8, v6}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v18

    invoke-virtual {v7, v10}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v8

    if-eqz v8, :cond_e0

    move v8, v10

    goto :goto_e1

    :cond_e0
    move v8, v6

    :goto_e1
    invoke-virtual {v7, v8, v6}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v19

    invoke-virtual {v7, v8}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v20

    invoke-virtual {v7}, Landroid/content/res/TypedArray;->recycle()V

    :goto_ec
    invoke-interface/range {p0 .. p0}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v7

    if-eq v7, v14, :cond_f6

    invoke-static/range {p0 .. p0}, Lp3/y;->H(Landroid/content/res/XmlResourceParser;)V

    goto :goto_ec

    :cond_f6
    new-instance v7, Lb0/g;

    move-object/from16 v16, v7

    invoke-direct/range {v16 .. v22}, Lb0/g;-><init>(IIILjava/lang/String;Ljava/lang/String;Z)V

    invoke-virtual {v4, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto/16 :goto_76

    :cond_102
    invoke-static/range {p0 .. p0}, Lp3/y;->H(Landroid/content/res/XmlResourceParser;)V

    goto/16 :goto_76

    :cond_107
    invoke-virtual {v4}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_10e

    goto :goto_11f

    :cond_10e
    new-instance v1, Lb0/f;

    new-array v0, v6, [Lb0/g;

    invoke-virtual {v4, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lb0/g;

    invoke-direct {v1, v0}, Lb0/f;-><init>([Lb0/g;)V

    goto :goto_120

    :cond_11c
    invoke-static/range {p0 .. p0}, Lp3/y;->H(Landroid/content/res/XmlResourceParser;)V

    :goto_11f
    const/4 v1, 0x0

    :goto_120
    return-object v1

    :cond_121
    new-instance v0, Lorg/xmlpull/v1/XmlPullParserException;

    const-string v1, "No start tag found"

    invoke-direct {v0, v1}, Lorg/xmlpull/v1/XmlPullParserException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static final E(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 4

    if-nez p0, :cond_4

    move-object p0, p1

    goto :goto_1c

    :cond_4
    instance-of v0, p0, Ljava/util/ArrayList;

    if-eqz v0, :cond_f

    move-object v0, p0

    check-cast v0, Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1c

    :cond_f
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x4

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-virtual {v0, p0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-object p0, v0

    :goto_1c
    return-object p0
.end method

.method public static F(ILandroid/content/res/Resources;)Ljava/util/List;
    .registers 10

    if-nez p0, :cond_7

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p0

    return-object p0

    :cond_7
    invoke-virtual {p1, p0}, Landroid/content/res/Resources;->obtainTypedArray(I)Landroid/content/res/TypedArray;

    move-result-object v0

    :try_start_b
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->length()I

    move-result v1

    if-nez v1, :cond_1b

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object p0
    :try_end_15
    .catchall {:try_start_b .. :try_end_15} :catchall_19

    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    return-object p0

    :catchall_19
    move-exception p0

    goto :goto_74

    :cond_1b
    :try_start_1b
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    invoke-static {v0, v2}, Lb0/d;->a(Landroid/content/res/TypedArray;I)I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_54

    move p0, v2

    :goto_29
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->length()I

    move-result v3

    if-ge p0, v3, :cond_70

    invoke-virtual {v0, p0, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v3

    if-eqz v3, :cond_51

    invoke-virtual {p1, v3}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    array-length v5, v3

    move v6, v2

    :goto_40
    if-ge v6, v5, :cond_4e

    aget-object v7, v3, v6

    invoke-static {v7, v2}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v7

    invoke-virtual {v4, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v6, v6, 0x1

    goto :goto_40

    :cond_4e
    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_51
    add-int/lit8 p0, p0, 0x1

    goto :goto_29

    :cond_54
    invoke-virtual {p1, p0}, Landroid/content/res/Resources;->getStringArray(I)[Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    array-length v3, p0

    move v4, v2

    :goto_5f
    if-ge v4, v3, :cond_6d

    aget-object v5, p0, v4

    invoke-static {v5, v2}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v5

    invoke-virtual {p1, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_5f

    :cond_6d
    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_70
    .catchall {:try_start_1b .. :try_end_70} :catchall_19

    :cond_70
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    return-object v1

    :goto_74
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    throw p0
.end method

.method public static final G(Landroid/view/View;La/g0;)V
    .registers 3

    const-string v0, "<this>"

    invoke-static {p0, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onBackPressedDispatcherOwner"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const v0, 0x7f0801d8

    invoke-virtual {p0, v0, p1}, Landroid/view/View;->setTag(ILjava/lang/Object;)V

    return-void
.end method

.method public static H(Landroid/content/res/XmlResourceParser;)V
    .registers 4

    const/4 v0, 0x1

    :goto_1
    if-lez v0, :cond_14

    invoke-interface {p0}, Lorg/xmlpull/v1/XmlPullParser;->next()I

    move-result v1

    const/4 v2, 0x2

    if-eq v1, v2, :cond_11

    const/4 v2, 0x3

    if-eq v1, v2, :cond_e

    goto :goto_1

    :cond_e
    add-int/lit8 v0, v0, -0x1

    goto :goto_1

    :cond_11
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    :cond_14
    return-void
.end method

.method public static final I(Ls3/e;Lc1/a;Ls3/n0;)Ls3/y;
    .registers 12

    sget-object v4, Lx2/n;->c:Lx2/n;

    sget-object v0, Lr3/j;->a:Lr3/i;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    sget-object v0, Lr3/i;->a:Lr3/i;

    instance-of v0, p0, Lt3/g;

    if-eqz v0, :cond_24

    move-object v0, p0

    check-cast v0, Lt3/g;

    invoke-virtual {v0}, Lt3/g;->f()Ls3/e;

    move-result-object v1

    if-eqz v1, :cond_24

    new-instance p0, Ls3/e0;

    const/4 v2, -0x3

    iget v3, v0, Lt3/g;->d:I

    if-eq v3, v2, :cond_1e

    const/4 v2, -0x2

    :cond_1e
    iget-object v0, v0, Lt3/g;->c:Lz2/j;

    invoke-direct {p0, v0, v1}, Ls3/e0;-><init>(Lz2/j;Ls3/e;)V

    goto :goto_2c

    :cond_24
    new-instance v0, Ls3/e0;

    sget-object v1, Lz2/k;->c:Lz2/k;

    invoke-direct {v0, v1, p0}, Ls3/e0;-><init>(Lz2/j;Ls3/e;)V

    move-object p0, v0

    :goto_2c
    new-instance v6, Ls3/q0;

    invoke-direct {v6, v4}, Ls3/q0;-><init>(Ljava/lang/Object;)V

    sget-object v0, Ls3/f0;->a:Ls3/h0;

    invoke-static {p2, v0}, Ld3/b;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3d

    sget-object v0, Lp3/w;->c:Lp3/w;

    :goto_3b
    move-object v7, v0

    goto :goto_40

    :cond_3d
    sget-object v0, Lp3/w;->f:Lp3/w;

    goto :goto_3b

    :goto_40
    new-instance v8, Ls3/u;

    const/4 v5, 0x0

    iget-object v2, p0, Ls3/e0;->a:Ls3/e;

    move-object v0, v8

    move-object v1, p2

    move-object v3, v6

    invoke-direct/range {v0 .. v5}, Ls3/u;-><init>(Ls3/g0;Ls3/e;Ls3/w;Ljava/lang/Object;Lz2/e;)V

    invoke-virtual {p1}, Lc1/a;->v()Lz2/j;

    move-result-object p1

    iget-object p0, p0, Ls3/e0;->b:Lz2/j;

    const/4 p2, 0x1

    invoke-static {p1, p0, p2}, Ld3/b;->c0(Lz2/j;Lz2/j;Z)Lz2/j;

    move-result-object p0

    sget-object p1, Lp3/e0;->a:Lv3/e;

    if-eq p0, p1, :cond_66

    sget-object v0, Lz2/f;->c:Lz2/f;

    invoke-interface {p0, v0}, Lz2/j;->g(Lz2/i;)Lz2/h;

    move-result-object v0

    if-nez v0, :cond_66

    invoke-interface {p0, p1}, Lz2/j;->i(Lz2/j;)Lz2/j;

    move-result-object p0

    :cond_66
    sget-object p1, Lp3/w;->d:Lp3/w;

    if-ne v7, p1, :cond_70

    new-instance p1, Lp3/g1;

    invoke-direct {p1, p0, v8}, Lp3/g1;-><init>(Lz2/j;Lg3/p;)V

    goto :goto_75

    :cond_70
    new-instance p1, Lp3/m1;

    invoke-direct {p1, p0, p2}, Lp3/a;-><init>(Lz2/j;Z)V

    :goto_75
    invoke-virtual {p1, v7, p1, v8}, Lp3/a;->W(Lp3/w;Lp3/a;Lg3/p;)V

    new-instance p0, Ls3/y;

    invoke-direct {p0, v6}, Ls3/y;-><init>(Ls3/q0;)V

    return-object p0
.end method

.method public static final J(Ljava/lang/String;JJJ)J
    .registers 31

    move-object/from16 v0, p0

    move-wide/from16 v1, p3

    move-wide/from16 v3, p5

    sget v5, Lu3/w;->a:I

    :try_start_8
    invoke-static/range {p0 .. p0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6
    :try_end_c
    .catch Ljava/lang/SecurityException; {:try_start_8 .. :try_end_c} :catch_d

    goto :goto_e

    :catch_d
    const/4 v6, 0x0

    :goto_e
    if-nez v6, :cond_14

    move-wide/from16 v5, p1

    goto/16 :goto_c0

    :cond_14
    new-instance v7, Ll3/c;

    const/4 v8, 0x2

    const/16 v9, 0x24

    const/4 v10, 0x1

    invoke-direct {v7, v8, v9, v10}, Ll3/a;-><init>(III)V

    iget v7, v7, Ll3/a;->d:I

    const/16 v11, 0xa

    if-gt v11, v7, :cond_117

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v7

    if-nez v7, :cond_2e

    :cond_29
    :goto_29
    move-object/from16 v19, v6

    :cond_2b
    :goto_2b
    const/4 v5, 0x0

    goto/16 :goto_ac

    :cond_2e
    const/4 v8, 0x0

    invoke-virtual {v6, v8}, Ljava/lang/String;->charAt(I)C

    move-result v9

    const/16 v12, 0x30

    if-ge v9, v12, :cond_39

    const/4 v12, -0x1

    goto :goto_3e

    :cond_39
    if-ne v9, v12, :cond_3d

    move v12, v8

    goto :goto_3e

    :cond_3d
    move v12, v10

    :goto_3e
    const-wide v13, -0x7fffffffffffffffL    # -4.9E-324

    if-gez v12, :cond_55

    if-ne v7, v10, :cond_48

    goto :goto_29

    :cond_48
    const/16 v12, 0x2d

    if-ne v9, v12, :cond_50

    const-wide/high16 v13, -0x8000000000000000L

    move v8, v10

    goto :goto_56

    :cond_50
    const/16 v12, 0x2b

    if-ne v9, v12, :cond_29

    goto :goto_56

    :cond_55
    move v10, v8

    :goto_56
    const-wide v15, -0x38e38e38e38e38eL    # -2.772000429909333E291

    const-wide/16 v17, 0x0

    move-wide/from16 v19, v17

    move-wide/from16 v17, v15

    :goto_61
    if-ge v10, v7, :cond_98

    invoke-virtual {v6, v10}, Ljava/lang/String;->charAt(I)C

    move-result v9

    invoke-static {v9, v11}, Ljava/lang/Character;->digit(II)I

    move-result v9

    if-gez v9, :cond_6e

    goto :goto_29

    :cond_6e
    move-wide/from16 v22, v19

    move-object/from16 v19, v6

    move-wide/from16 v5, v22

    cmp-long v20, v5, v17

    if-gez v20, :cond_84

    cmp-long v17, v17, v15

    if-nez v17, :cond_2b

    int-to-long v3, v11

    div-long v17, v13, v3

    cmp-long v3, v5, v17

    if-gez v3, :cond_84

    goto :goto_2b

    :cond_84
    int-to-long v3, v11

    mul-long/2addr v3, v5

    int-to-long v5, v9

    add-long v20, v13, v5

    cmp-long v9, v3, v20

    if-gez v9, :cond_8e

    goto :goto_2b

    :cond_8e
    sub-long/2addr v3, v5

    add-int/lit8 v10, v10, 0x1

    move-object/from16 v6, v19

    move-wide/from16 v19, v3

    move-wide/from16 v3, p5

    goto :goto_61

    :cond_98
    move-wide/from16 v22, v19

    move-object/from16 v19, v6

    move-wide/from16 v5, v22

    if-eqz v8, :cond_a6

    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    :goto_a4
    move-object v5, v3

    goto :goto_ac

    :cond_a6
    neg-long v3, v5

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    goto :goto_a4

    :goto_ac
    const/16 v3, 0x27

    const-string v4, "System property \'"

    if-eqz v5, :cond_f4

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    cmp-long v7, v1, v5

    if-gtz v7, :cond_c1

    move-wide/from16 v7, p5

    cmp-long v9, v5, v7

    if-gtz v9, :cond_c3

    :goto_c0
    return-wide v5

    :cond_c1
    move-wide/from16 v7, p5

    :cond_c3
    new-instance v9, Ljava/lang/IllegalStateException;

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\' should be in range "

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v0, ".."

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v0, ", but is \'"

    invoke-virtual {v10, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v9, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v9

    :cond_f4
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\' has unrecognized value \'"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-object/from16 v5, v19

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    :cond_117
    new-instance v0, Ljava/lang/IllegalArgumentException;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "radix 10 was not in valid range "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    new-instance v2, Ll3/c;

    invoke-direct {v2, v8, v9, v10}, Ll3/a;-><init>(III)V

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static K(Ljava/lang/String;IIII)I
    .registers 12

    and-int/lit8 v0, p4, 0x4

    if-eqz v0, :cond_5

    const/4 p2, 0x1

    :cond_5
    and-int/lit8 p4, p4, 0x8

    if-eqz p4, :cond_c

    const p3, 0x7fffffff

    :cond_c
    int-to-long v1, p1

    int-to-long v3, p2

    int-to-long v5, p3

    move-object v0, p0

    invoke-static/range {v0 .. v6}, Lp3/y;->J(Ljava/lang/String;JJJ)J

    move-result-wide p0

    long-to-int p0, p0

    return p0
.end method

.method public static final L(Lz2/e;)Ljava/lang/String;
    .registers 4

    instance-of v0, p0, Lu3/h;

    if-eqz v0, :cond_9

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p0

    goto :goto_4f

    :cond_9
    const/16 v0, 0x40

    :try_start_b
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-static {p0}, Lp3/y;->q(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_21
    .catchall {:try_start_b .. :try_end_21} :catchall_22

    goto :goto_27

    :catchall_22
    move-exception v1

    invoke-static {v1}, Ld3/b;->U(Ljava/lang/Throwable;)Lw2/d;

    move-result-object v1

    :goto_27
    invoke-static {v1}, Lw2/e;->a(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v2

    if-nez v2, :cond_2e

    goto :goto_4c

    :cond_2e
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-static {p0}, Lp3/y;->q(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_4c
    move-object p0, v1

    check-cast p0, Ljava/lang/String;

    :goto_4f
    return-object p0
.end method

.method public static final M(Lz2/j;Ljava/lang/Object;Ljava/lang/Object;Lg3/p;Lz2/e;)Ljava/lang/Object;
    .registers 7

    invoke-static {p0, p2}, Lu3/a;->g(Lz2/j;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    :try_start_4
    new-instance v0, Lt3/e0;

    invoke-direct {v0, p4, p0}, Lt3/e0;-><init>(Lz2/e;Lz2/j;)V

    instance-of v1, p3, Lb3/a;

    if-nez v1, :cond_14

    invoke-static {p1, v0, p3}, Ld3/b;->g2(Ljava/lang/Object;Lz2/e;Lg3/p;)Ljava/lang/Object;

    move-result-object p1

    goto :goto_1c

    :catchall_12
    move-exception p1

    goto :goto_29

    :cond_14
    const/4 v1, 0x2

    invoke-static {v1, p3}, Ld3/b;->p(ILjava/lang/Object;)V

    invoke-interface {p3, p1, v0}, Lg3/p;->f(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1
    :try_end_1c
    .catchall {:try_start_4 .. :try_end_1c} :catchall_12

    :goto_1c
    invoke-static {p0, p2}, Lu3/a;->b(Lz2/j;Ljava/lang/Object;)V

    sget-object p0, La3/a;->c:La3/a;

    if-ne p1, p0, :cond_28

    const-string p0, "frame"

    invoke-static {p4, p0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_28
    return-object p1

    :goto_29
    invoke-static {p0, p2}, Lu3/a;->b(Lz2/j;Ljava/lang/Object;)V

    throw p1
.end method

.method public static a(ILr3/a;I)Lr3/f;
    .registers 7

    and-int/lit8 v0, p2, 0x1

    const/4 v1, 0x0

    if-eqz v0, :cond_6

    move p0, v1

    :cond_6
    and-int/lit8 p2, p2, 0x2

    sget-object v0, Lr3/a;->c:Lr3/a;

    if-eqz p2, :cond_d

    move-object p1, v0

    :cond_d
    const/4 p2, -0x2

    const/4 v2, 0x0

    const/4 v3, 0x1

    if-eq p0, p2, :cond_56

    const/4 p2, -0x1

    if-eq p0, p2, :cond_40

    if-eqz p0, :cond_31

    const p2, 0x7fffffff

    if-eq p0, p2, :cond_2b

    if-ne p1, v0, :cond_24

    new-instance p1, Lr3/f;

    invoke-direct {p1, p0, v2}, Lr3/f;-><init>(ILg3/l;)V

    goto :goto_6b

    :cond_24
    new-instance p2, Lr3/q;

    invoke-direct {p2, p0, p1, v2}, Lr3/q;-><init>(ILr3/a;Lg3/l;)V

    move-object p1, p2

    goto :goto_6b

    :cond_2b
    new-instance p1, Lr3/f;

    invoke-direct {p1, p2, v2}, Lr3/f;-><init>(ILg3/l;)V

    goto :goto_6b

    :cond_31
    if-ne p1, v0, :cond_3a

    new-instance p0, Lr3/f;

    invoke-direct {p0, v1, v2}, Lr3/f;-><init>(ILg3/l;)V

    :goto_38
    move-object p1, p0

    goto :goto_6b

    :cond_3a
    new-instance p0, Lr3/q;

    invoke-direct {p0, v3, p1, v2}, Lr3/q;-><init>(ILr3/a;Lg3/l;)V

    goto :goto_38

    :cond_40
    if-ne p1, v0, :cond_4a

    new-instance p1, Lr3/q;

    sget-object p0, Lr3/a;->d:Lr3/a;

    invoke-direct {p1, v3, p0, v2}, Lr3/q;-><init>(ILr3/a;Lg3/l;)V

    goto :goto_6b

    :cond_4a
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string p1, "CONFLATED capacity cannot be used with non-default onBufferOverflow"

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_56
    if-ne p1, v0, :cond_65

    new-instance p0, Lr3/f;

    sget-object p1, Lr3/j;->a:Lr3/i;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    sget p1, Lr3/i;->b:I

    invoke-direct {p0, p1, v2}, Lr3/f;-><init>(ILg3/l;)V

    goto :goto_38

    :cond_65
    new-instance p0, Lr3/q;

    invoke-direct {p0, v3, p1, v2}, Lr3/q;-><init>(ILr3/a;Lg3/l;)V

    goto :goto_38

    :goto_6b
    return-object p1
.end method

.method public static b(Lt/e;Ls/e;I)V
    .registers 40

    move-object/from16 v0, p0

    move-object/from16 v10, p1

    const/4 v11, 0x2

    if-nez p2, :cond_f

    iget v1, v0, Lt/e;->l0:I

    iget-object v2, v0, Lt/e;->o0:[Lt/b;

    move v13, v1

    move-object v14, v2

    const/4 v15, 0x0

    goto :goto_16

    :cond_f
    iget v1, v0, Lt/e;->m0:I

    iget-object v2, v0, Lt/e;->n0:[Lt/b;

    move v13, v1

    move-object v14, v2

    move v15, v11

    :goto_16
    const/4 v9, 0x0

    :goto_17
    if-ge v9, v13, :cond_71c

    aget-object v1, v14, v9

    iget-boolean v2, v1, Lt/b;->q:Z

    iget-object v8, v1, Lt/b;->a:Lt/d;

    const/4 v3, 0x3

    const/4 v4, 0x1

    const/16 v7, 0x8

    const/16 v16, 0x0

    if-nez v2, :cond_151

    iget v2, v1, Lt/b;->l:I

    mul-int/lit8 v6, v2, 0x2

    move-object v12, v8

    move-object/from16 v19, v12

    const/16 v17, 0x0

    :goto_30
    if-nez v17, :cond_11b

    iget v5, v1, Lt/b;->i:I

    add-int/2addr v5, v4

    iput v5, v1, Lt/b;->i:I

    iget-object v5, v12, Lt/d;->b0:[Lt/d;

    aput-object v16, v5, v2

    iget-object v5, v12, Lt/d;->a0:[Lt/d;

    aput-object v16, v5, v2

    iget v5, v12, Lt/d;->V:I

    iget-object v4, v12, Lt/d;->F:[Lt/c;

    if-eq v5, v7, :cond_e8

    invoke-virtual {v12, v2}, Lt/d;->i(I)I

    aget-object v5, v4, v6

    invoke-virtual {v5}, Lt/c;->c()I

    add-int/lit8 v5, v6, 0x1

    aget-object v22, v4, v5

    invoke-virtual/range {v22 .. v22}, Lt/c;->c()I

    aget-object v22, v4, v6

    invoke-virtual/range {v22 .. v22}, Lt/c;->c()I

    aget-object v5, v4, v5

    invoke-virtual {v5}, Lt/c;->c()I

    iget-object v5, v1, Lt/b;->b:Lt/d;

    if-nez v5, :cond_64

    iput-object v12, v1, Lt/b;->b:Lt/d;

    :cond_64
    iput-object v12, v1, Lt/b;->d:Lt/d;

    iget-object v5, v12, Lt/d;->c0:[I

    aget v5, v5, v2

    if-ne v5, v3, :cond_e8

    iget-object v7, v12, Lt/d;->l:[I

    aget v7, v7, v2

    if-eqz v7, :cond_7a

    if-eq v7, v3, :cond_7a

    if-ne v7, v11, :cond_77

    goto :goto_7a

    :cond_77
    move/from16 v24, v9

    goto :goto_cc

    :cond_7a
    :goto_7a
    iget v11, v1, Lt/b;->j:I

    const/16 v21, 0x1

    add-int/lit8 v11, v11, 0x1

    iput v11, v1, Lt/b;->j:I

    iget-object v11, v12, Lt/d;->Z:[F

    aget v11, v11, v2

    const/16 v20, 0x0

    cmpl-float v23, v11, v20

    if-lez v23, :cond_91

    iget v3, v1, Lt/b;->k:F

    add-float/2addr v3, v11

    iput v3, v1, Lt/b;->k:F

    :cond_91
    iget v3, v12, Lt/d;->V:I

    move/from16 v24, v9

    const/16 v9, 0x8

    if-eq v3, v9, :cond_bc

    const/4 v3, 0x3

    if-ne v5, v3, :cond_bc

    if-eqz v7, :cond_a0

    if-ne v7, v3, :cond_bc

    :cond_a0
    const/4 v3, 0x0

    cmpg-float v5, v11, v3

    if-gez v5, :cond_a9

    const/4 v3, 0x1

    iput-boolean v3, v1, Lt/b;->n:Z

    goto :goto_ac

    :cond_a9
    const/4 v3, 0x1

    iput-boolean v3, v1, Lt/b;->o:Z

    :goto_ac
    iget-object v3, v1, Lt/b;->h:Ljava/util/ArrayList;

    if-nez v3, :cond_b7

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    iput-object v3, v1, Lt/b;->h:Ljava/util/ArrayList;

    :cond_b7
    iget-object v3, v1, Lt/b;->h:Ljava/util/ArrayList;

    invoke-virtual {v3, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_bc
    iget-object v3, v1, Lt/b;->f:Lt/d;

    if-nez v3, :cond_c2

    iput-object v12, v1, Lt/b;->f:Lt/d;

    :cond_c2
    iget-object v3, v1, Lt/b;->g:Lt/d;

    if-eqz v3, :cond_ca

    iget-object v3, v3, Lt/d;->a0:[Lt/d;

    aput-object v12, v3, v2

    :cond_ca
    iput-object v12, v1, Lt/b;->g:Lt/d;

    :goto_cc
    if-nez v2, :cond_da

    iget v3, v12, Lt/d;->j:I

    if-eqz v3, :cond_d3

    goto :goto_e5

    :cond_d3
    iget v3, v12, Lt/d;->m:I

    if-nez v3, :cond_e5

    iget v3, v12, Lt/d;->n:I

    goto :goto_e5

    :cond_da
    iget v3, v12, Lt/d;->k:I

    if-eqz v3, :cond_df

    goto :goto_e5

    :cond_df
    iget v3, v12, Lt/d;->p:I

    if-nez v3, :cond_e5

    iget v3, v12, Lt/d;->q:I

    :cond_e5
    :goto_e5
    move-object/from16 v3, v19

    goto :goto_eb

    :cond_e8
    move/from16 v24, v9

    goto :goto_e5

    :goto_eb
    if-eq v3, v12, :cond_f1

    iget-object v3, v3, Lt/d;->b0:[Lt/d;

    aput-object v12, v3, v2

    :cond_f1
    add-int/lit8 v3, v6, 0x1

    aget-object v3, v4, v3

    iget-object v3, v3, Lt/c;->d:Lt/c;

    if-eqz v3, :cond_107

    iget-object v3, v3, Lt/c;->b:Lt/d;

    iget-object v4, v3, Lt/d;->F:[Lt/c;

    aget-object v4, v4, v6

    iget-object v4, v4, Lt/c;->d:Lt/c;

    if-eqz v4, :cond_107

    iget-object v4, v4, Lt/c;->b:Lt/d;

    if-eq v4, v12, :cond_109

    :cond_107
    move-object/from16 v3, v16

    :cond_109
    if-eqz v3, :cond_10c

    goto :goto_10f

    :cond_10c
    move-object v3, v12

    const/16 v17, 0x1

    :goto_10f
    move-object/from16 v19, v12

    move/from16 v9, v24

    const/4 v4, 0x1

    const/16 v7, 0x8

    const/4 v11, 0x2

    move-object v12, v3

    const/4 v3, 0x3

    goto/16 :goto_30

    :cond_11b
    move/from16 v24, v9

    iget-object v3, v1, Lt/b;->b:Lt/d;

    if-eqz v3, :cond_128

    iget-object v3, v3, Lt/d;->F:[Lt/c;

    aget-object v3, v3, v6

    invoke-virtual {v3}, Lt/c;->c()I

    :cond_128
    iget-object v3, v1, Lt/b;->d:Lt/d;

    if-eqz v3, :cond_135

    add-int/lit8 v6, v6, 0x1

    iget-object v3, v3, Lt/d;->F:[Lt/c;

    aget-object v3, v3, v6

    invoke-virtual {v3}, Lt/c;->c()I

    :cond_135
    iput-object v12, v1, Lt/b;->c:Lt/d;

    if-nez v2, :cond_140

    iget-boolean v2, v1, Lt/b;->m:Z

    if-eqz v2, :cond_140

    iput-object v12, v1, Lt/b;->e:Lt/d;

    goto :goto_142

    :cond_140
    iput-object v8, v1, Lt/b;->e:Lt/d;

    :goto_142
    iget-boolean v2, v1, Lt/b;->o:Z

    if-eqz v2, :cond_14c

    iget-boolean v2, v1, Lt/b;->n:Z

    if-eqz v2, :cond_14c

    const/4 v2, 0x1

    goto :goto_14d

    :cond_14c
    const/4 v2, 0x0

    :goto_14d
    iput-boolean v2, v1, Lt/b;->p:Z

    const/4 v2, 0x1

    goto :goto_154

    :cond_151
    move/from16 v24, v9

    move v2, v4

    :goto_154
    iput-boolean v2, v1, Lt/b;->q:Z

    iget-object v11, v1, Lt/b;->c:Lt/d;

    iget-object v12, v1, Lt/b;->b:Lt/d;

    iget-object v9, v1, Lt/b;->d:Lt/d;

    iget-object v2, v1, Lt/b;->e:Lt/d;

    iget v3, v1, Lt/b;->k:F

    iget-object v4, v0, Lt/d;->c0:[I

    aget v4, v4, p2

    const/4 v7, 0x2

    if-ne v4, v7, :cond_169

    const/4 v4, 0x1

    goto :goto_16a

    :cond_169
    const/4 v4, 0x0

    :goto_16a
    if-nez p2, :cond_189

    iget v5, v2, Lt/d;->X:I

    const/4 v6, 0x1

    if-nez v5, :cond_174

    const/16 v21, 0x1

    goto :goto_176

    :cond_174
    const/16 v21, 0x0

    :goto_176
    if-ne v5, v6, :cond_17b

    move/from16 v17, v6

    goto :goto_17d

    :cond_17b
    const/16 v17, 0x0

    :goto_17d
    if-ne v5, v7, :cond_181

    move v5, v6

    goto :goto_182

    :cond_181
    const/4 v5, 0x0

    :goto_182
    move/from16 v25, v3

    move-object v7, v8

    move/from16 v19, v21

    :goto_187
    const/4 v6, 0x0

    goto :goto_1a5

    :cond_189
    const/4 v6, 0x1

    iget v5, v2, Lt/d;->Y:I

    if-nez v5, :cond_191

    move/from16 v17, v6

    goto :goto_193

    :cond_191
    const/16 v17, 0x0

    :goto_193
    if-ne v5, v6, :cond_197

    const/4 v6, 0x1

    goto :goto_198

    :cond_197
    const/4 v6, 0x0

    :goto_198
    if-ne v5, v7, :cond_19c

    const/4 v5, 0x1

    goto :goto_19d

    :cond_19c
    const/4 v5, 0x0

    :goto_19d
    move/from16 v25, v3

    move-object v7, v8

    move/from16 v19, v17

    move/from16 v17, v6

    goto :goto_187

    :goto_1a5
    iget-object v3, v0, Lt/d;->F:[Lt/c;

    move/from16 v26, v13

    if-nez v6, :cond_27b

    iget-object v13, v7, Lt/d;->F:[Lt/c;

    aget-object v13, v13, v15

    if-eqz v5, :cond_1b4

    const/16 v27, 0x1

    goto :goto_1b6

    :cond_1b4
    const/16 v27, 0x4

    :goto_1b6
    invoke-virtual {v13}, Lt/c;->c()I

    move-result v28

    move/from16 v29, v6

    iget-object v6, v7, Lt/d;->c0:[I

    move-object/from16 v30, v14

    aget v14, v6, p2

    move-object/from16 v31, v2

    const/4 v2, 0x3

    if-ne v14, v2, :cond_1cf

    iget-object v2, v7, Lt/d;->l:[I

    aget v2, v2, p2

    if-nez v2, :cond_1cf

    const/4 v2, 0x1

    goto :goto_1d0

    :cond_1cf
    const/4 v2, 0x0

    :goto_1d0
    iget-object v14, v13, Lt/c;->d:Lt/c;

    if-eqz v14, :cond_1dc

    if-eq v7, v8, :cond_1dc

    invoke-virtual {v14}, Lt/c;->c()I

    move-result v14

    add-int v28, v14, v28

    :cond_1dc
    move/from16 v14, v28

    if-eqz v5, :cond_1e9

    if-eq v7, v8, :cond_1e9

    if-eq v7, v12, :cond_1e9

    move-object/from16 v28, v8

    const/16 v27, 0x5

    goto :goto_1eb

    :cond_1e9
    move-object/from16 v28, v8

    :goto_1eb
    iget-object v8, v13, Lt/c;->d:Lt/c;

    if-eqz v8, :cond_21d

    if-ne v7, v12, :cond_1fe

    move-object/from16 v32, v12

    iget-object v12, v13, Lt/c;->g:Ls/k;

    iget-object v8, v8, Lt/c;->g:Ls/k;

    move-object/from16 v33, v1

    const/4 v1, 0x6

    invoke-virtual {v10, v12, v8, v14, v1}, Ls/e;->f(Ls/k;Ls/k;II)V

    goto :goto_20b

    :cond_1fe
    move-object/from16 v33, v1

    move-object/from16 v32, v12

    iget-object v1, v13, Lt/c;->g:Ls/k;

    iget-object v8, v8, Lt/c;->g:Ls/k;

    const/16 v12, 0x8

    invoke-virtual {v10, v1, v8, v14, v12}, Ls/e;->f(Ls/k;Ls/k;II)V

    :goto_20b
    if-eqz v2, :cond_211

    if-nez v5, :cond_211

    const/4 v1, 0x5

    goto :goto_213

    :cond_211
    move/from16 v1, v27

    :goto_213
    iget-object v2, v13, Lt/c;->g:Ls/k;

    iget-object v8, v13, Lt/c;->d:Lt/c;

    iget-object v8, v8, Lt/c;->g:Ls/k;

    invoke-virtual {v10, v2, v8, v14, v1}, Ls/e;->e(Ls/k;Ls/k;II)V

    goto :goto_221

    :cond_21d
    move-object/from16 v33, v1

    move-object/from16 v32, v12

    :goto_221
    iget-object v1, v7, Lt/d;->F:[Lt/c;

    if-eqz v4, :cond_24e

    iget v2, v7, Lt/d;->V:I

    const/16 v8, 0x8

    if-eq v2, v8, :cond_240

    aget v2, v6, p2

    const/4 v6, 0x3

    if-ne v2, v6, :cond_240

    add-int/lit8 v2, v15, 0x1

    aget-object v2, v1, v2

    iget-object v2, v2, Lt/c;->g:Ls/k;

    aget-object v6, v1, v15

    iget-object v6, v6, Lt/c;->g:Ls/k;

    const/4 v8, 0x0

    const/4 v12, 0x5

    invoke-virtual {v10, v2, v6, v8, v12}, Ls/e;->f(Ls/k;Ls/k;II)V

    goto :goto_241

    :cond_240
    const/4 v8, 0x0

    :goto_241
    aget-object v2, v1, v15

    iget-object v2, v2, Lt/c;->g:Ls/k;

    aget-object v3, v3, v15

    iget-object v3, v3, Lt/c;->g:Ls/k;

    const/16 v6, 0x8

    invoke-virtual {v10, v2, v3, v8, v6}, Ls/e;->f(Ls/k;Ls/k;II)V

    :cond_24e
    add-int/lit8 v2, v15, 0x1

    aget-object v1, v1, v2

    iget-object v1, v1, Lt/c;->d:Lt/c;

    if-eqz v1, :cond_264

    iget-object v1, v1, Lt/c;->b:Lt/d;

    iget-object v2, v1, Lt/d;->F:[Lt/c;

    aget-object v2, v2, v15

    iget-object v2, v2, Lt/c;->d:Lt/c;

    if-eqz v2, :cond_264

    iget-object v2, v2, Lt/c;->b:Lt/d;

    if-eq v2, v7, :cond_266

    :cond_264
    move-object/from16 v1, v16

    :cond_266
    if-eqz v1, :cond_26c

    move-object v7, v1

    move/from16 v6, v29

    goto :goto_26d

    :cond_26c
    const/4 v6, 0x1

    :goto_26d
    move/from16 v13, v26

    move-object/from16 v8, v28

    move-object/from16 v14, v30

    move-object/from16 v2, v31

    move-object/from16 v12, v32

    move-object/from16 v1, v33

    goto/16 :goto_1a5

    :cond_27b
    move-object/from16 v33, v1

    move-object/from16 v31, v2

    move-object/from16 v28, v8

    move-object/from16 v32, v12

    move-object/from16 v30, v14

    if-eqz v9, :cond_2e2

    iget-object v1, v11, Lt/d;->F:[Lt/c;

    add-int/lit8 v2, v15, 0x1

    aget-object v1, v1, v2

    iget-object v1, v1, Lt/c;->d:Lt/c;

    if-eqz v1, :cond_2e2

    iget-object v1, v9, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v2

    iget-object v6, v9, Lt/d;->c0:[I

    aget v6, v6, p2

    const/4 v7, 0x3

    if-ne v6, v7, :cond_2b8

    iget-object v6, v9, Lt/d;->l:[I

    aget v6, v6, p2

    if-nez v6, :cond_2b8

    if-nez v5, :cond_2b8

    iget-object v6, v1, Lt/c;->d:Lt/c;

    iget-object v7, v6, Lt/c;->b:Lt/d;

    if-ne v7, v0, :cond_2b8

    iget-object v7, v1, Lt/c;->g:Ls/k;

    iget-object v6, v6, Lt/c;->g:Ls/k;

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v8

    neg-int v8, v8

    const/4 v12, 0x5

    invoke-virtual {v10, v7, v6, v8, v12}, Ls/e;->e(Ls/k;Ls/k;II)V

    goto :goto_2ce

    :cond_2b8
    const/4 v12, 0x5

    if-eqz v5, :cond_2ce

    iget-object v6, v1, Lt/c;->d:Lt/c;

    iget-object v7, v6, Lt/c;->b:Lt/d;

    if-ne v7, v0, :cond_2ce

    iget-object v7, v1, Lt/c;->g:Ls/k;

    iget-object v6, v6, Lt/c;->g:Ls/k;

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v8

    neg-int v8, v8

    const/4 v13, 0x4

    invoke-virtual {v10, v7, v6, v8, v13}, Ls/e;->e(Ls/k;Ls/k;II)V

    :cond_2ce
    :goto_2ce
    iget-object v6, v1, Lt/c;->g:Ls/k;

    iget-object v7, v11, Lt/d;->F:[Lt/c;

    aget-object v2, v7, v2

    iget-object v2, v2, Lt/c;->d:Lt/c;

    iget-object v2, v2, Lt/c;->g:Ls/k;

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    neg-int v1, v1

    const/4 v7, 0x6

    invoke-virtual {v10, v6, v2, v1, v7}, Ls/e;->g(Ls/k;Ls/k;II)V

    goto :goto_2e3

    :cond_2e2
    const/4 v12, 0x5

    :goto_2e3
    if-eqz v4, :cond_2fa

    add-int/lit8 v1, v15, 0x1

    aget-object v2, v3, v1

    iget-object v2, v2, Lt/c;->g:Ls/k;

    iget-object v3, v11, Lt/d;->F:[Lt/c;

    aget-object v1, v3, v1

    iget-object v3, v1, Lt/c;->g:Ls/k;

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    const/16 v4, 0x8

    invoke-virtual {v10, v2, v3, v1, v4}, Ls/e;->f(Ls/k;Ls/k;II)V

    :cond_2fa
    move-object/from16 v1, v33

    iget-object v2, v1, Lt/b;->h:Ljava/util/ArrayList;

    if-eqz v2, :cond_419

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v3

    const/4 v4, 0x1

    if-le v3, v4, :cond_419

    iget-boolean v6, v1, Lt/b;->n:Z

    if-eqz v6, :cond_313

    iget-boolean v6, v1, Lt/b;->p:Z

    if-nez v6, :cond_313

    iget v6, v1, Lt/b;->j:I

    int-to-float v6, v6

    goto :goto_315

    :cond_313
    move/from16 v6, v25

    :goto_315
    move-object/from16 v13, v16

    const/4 v7, 0x0

    const/4 v8, 0x0

    :goto_319
    if-ge v8, v3, :cond_419

    invoke-virtual {v2, v8}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v14

    check-cast v14, Lt/d;

    iget-object v4, v14, Lt/d;->Z:[F

    aget v4, v4, p2

    const/16 v20, 0x0

    cmpg-float v23, v4, v20

    iget-object v12, v14, Lt/d;->F:[Lt/c;

    if-gez v23, :cond_34a

    iget-boolean v4, v1, Lt/b;->p:Z

    if-eqz v4, :cond_343

    add-int/lit8 v0, v15, 0x1

    aget-object v0, v12, v0

    iget-object v0, v0, Lt/c;->g:Ls/k;

    aget-object v4, v12, v15

    iget-object v4, v4, Lt/c;->g:Ls/k;

    const/4 v12, 0x0

    const/4 v14, 0x4

    invoke-virtual {v10, v0, v4, v12, v14}, Ls/e;->e(Ls/k;Ls/k;II)V

    move/from16 v23, v14

    goto :goto_361

    :cond_343
    const/16 v23, 0x4

    const/high16 v4, 0x3f800000    # 1.0f

    :goto_347
    const/16 v20, 0x0

    goto :goto_34d

    :cond_34a
    const/16 v23, 0x4

    goto :goto_347

    :goto_34d
    cmpl-float v25, v4, v20

    if-nez v25, :cond_36b

    add-int/lit8 v0, v15, 0x1

    aget-object v0, v12, v0

    iget-object v0, v0, Lt/c;->g:Ls/k;

    aget-object v4, v12, v15

    iget-object v4, v4, Lt/c;->g:Ls/k;

    const/4 v12, 0x0

    const/16 v14, 0x8

    invoke-virtual {v10, v0, v4, v12, v14}, Ls/e;->e(Ls/k;Ls/k;II)V

    :goto_361
    move-object/from16 v29, v2

    move/from16 v27, v3

    move/from16 v18, v12

    const/16 v20, 0x0

    goto/16 :goto_40d

    :cond_36b
    const/16 v18, 0x0

    if-eqz v13, :cond_3ff

    iget-object v13, v13, Lt/d;->F:[Lt/c;

    aget-object v0, v13, v15

    iget-object v0, v0, Lt/c;->g:Ls/k;

    add-int/lit8 v27, v15, 0x1

    aget-object v13, v13, v27

    iget-object v13, v13, Lt/c;->g:Ls/k;

    move-object/from16 v29, v2

    aget-object v2, v12, v15

    iget-object v2, v2, Lt/c;->g:Ls/k;

    aget-object v12, v12, v27

    iget-object v12, v12, Lt/c;->g:Ls/k;

    move/from16 v27, v3

    invoke-virtual/range {p1 .. p1}, Ls/e;->k()Ls/c;

    move-result-object v3

    move-object/from16 v33, v14

    const/4 v14, 0x0

    iput v14, v3, Ls/c;->b:F

    cmpl-float v20, v6, v14

    const/high16 v14, -0x40800000    # -1.0f

    if-eqz v20, :cond_39a

    cmpl-float v20, v7, v4

    if-nez v20, :cond_3a2

    :cond_39a
    move/from16 v25, v4

    move v4, v14

    const/high16 v14, 0x3f800000    # 1.0f

    const/16 v20, 0x0

    goto :goto_3e7

    :cond_3a2
    const/16 v20, 0x0

    cmpl-float v34, v7, v20

    if-nez v34, :cond_3b7

    iget-object v2, v3, Ls/c;->d:Ls/b;

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-interface {v2, v0, v7}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    invoke-interface {v0, v13, v14}, Ls/b;->i(Ls/k;F)V

    :goto_3b4
    move/from16 v25, v4

    goto :goto_3fb

    :cond_3b7
    const/high16 v14, 0x3f800000    # 1.0f

    if-nez v25, :cond_3c8

    iget-object v0, v3, Ls/c;->d:Ls/b;

    invoke-interface {v0, v2, v14}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    const/high16 v2, -0x40800000    # -1.0f

    invoke-interface {v0, v12, v2}, Ls/b;->i(Ls/k;F)V

    goto :goto_3b4

    :cond_3c8
    div-float/2addr v7, v6

    div-float v25, v4, v6

    div-float v7, v7, v25

    move/from16 v25, v4

    iget-object v4, v3, Ls/c;->d:Ls/b;

    invoke-interface {v4, v0, v14}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    const/high16 v4, -0x40800000    # -1.0f

    invoke-interface {v0, v13, v4}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    invoke-interface {v0, v12, v7}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    neg-float v4, v7

    invoke-interface {v0, v2, v4}, Ls/b;->i(Ls/k;F)V

    goto :goto_3fb

    :goto_3e7
    iget-object v7, v3, Ls/c;->d:Ls/b;

    invoke-interface {v7, v0, v14}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    invoke-interface {v0, v13, v4}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    invoke-interface {v0, v12, v14}, Ls/b;->i(Ls/k;F)V

    iget-object v0, v3, Ls/c;->d:Ls/b;

    invoke-interface {v0, v2, v4}, Ls/b;->i(Ls/k;F)V

    :goto_3fb
    invoke-virtual {v10, v3}, Ls/e;->c(Ls/c;)V

    goto :goto_409

    :cond_3ff
    move-object/from16 v29, v2

    move/from16 v27, v3

    move/from16 v25, v4

    move-object/from16 v33, v14

    const/16 v20, 0x0

    :goto_409
    move/from16 v7, v25

    move-object/from16 v13, v33

    :goto_40d
    add-int/lit8 v8, v8, 0x1

    move/from16 v3, v27

    move-object/from16 v2, v29

    const/4 v4, 0x1

    const/4 v12, 0x5

    move-object/from16 v0, p0

    goto/16 :goto_319

    :cond_419
    const/16 v18, 0x0

    const/16 v23, 0x4

    if-eqz v32, :cond_489

    move-object/from16 v0, v32

    if-eq v0, v9, :cond_425

    if-eqz v5, :cond_428

    :cond_425
    move-object/from16 v8, v28

    goto :goto_42f

    :cond_428
    move-object v14, v9

    move/from16 v12, v24

    move-object/from16 v8, v28

    goto/16 :goto_490

    :goto_42f
    iget-object v1, v8, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v15

    iget-object v2, v11, Lt/d;->F:[Lt/c;

    add-int/lit8 v3, v15, 0x1

    aget-object v2, v2, v3

    iget-object v1, v1, Lt/c;->d:Lt/c;

    if-eqz v1, :cond_441

    iget-object v1, v1, Lt/c;->g:Ls/k;

    move-object v4, v1

    goto :goto_443

    :cond_441
    move-object/from16 v4, v16

    :goto_443
    iget-object v1, v2, Lt/c;->d:Lt/c;

    if-eqz v1, :cond_44b

    iget-object v1, v1, Lt/c;->g:Ls/k;

    move-object v6, v1

    goto :goto_44d

    :cond_44b
    move-object/from16 v6, v16

    :goto_44d
    iget-object v1, v0, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v15

    iget-object v2, v9, Lt/d;->F:[Lt/c;

    aget-object v2, v2, v3

    if-eqz v4, :cond_482

    if-eqz v6, :cond_482

    if-nez p2, :cond_461

    move-object/from16 v3, v31

    iget v3, v3, Lt/d;->S:F

    :goto_45f
    move v5, v3

    goto :goto_466

    :cond_461
    move-object/from16 v3, v31

    iget v3, v3, Lt/d;->T:F

    goto :goto_45f

    :goto_466
    invoke-virtual {v1}, Lt/c;->c()I

    move-result v7

    invoke-virtual {v2}, Lt/c;->c()I

    move-result v8

    iget-object v3, v1, Lt/c;->g:Ls/k;

    iget-object v12, v2, Lt/c;->g:Ls/k;

    const/4 v13, 0x7

    move-object/from16 v1, p1

    move-object v2, v3

    move-object v3, v4

    move v4, v7

    const/4 v14, 0x2

    move-object v7, v12

    move-object v14, v9

    move/from16 v12, v24

    move v9, v13

    invoke-virtual/range {v1 .. v9}, Ls/e;->b(Ls/k;Ls/k;IFLs/k;Ls/k;II)V

    goto :goto_485

    :cond_482
    move-object v14, v9

    move/from16 v12, v24

    :cond_485
    :goto_485
    move/from16 v22, v12

    goto/16 :goto_6ba

    :cond_489
    move-object v14, v9

    move/from16 v12, v24

    move-object/from16 v8, v28

    move-object/from16 v0, v32

    :goto_490
    if-eqz v19, :cond_58d

    if-eqz v0, :cond_58d

    iget v2, v1, Lt/b;->j:I

    if-lez v2, :cond_49f

    iget v1, v1, Lt/b;->i:I

    if-ne v1, v2, :cond_49f

    const/16 v21, 0x1

    goto :goto_4a1

    :cond_49f
    move/from16 v21, v18

    :goto_4a1
    move-object v9, v0

    move-object v13, v9

    :goto_4a3
    if-eqz v13, :cond_485

    iget-object v1, v13, Lt/d;->b0:[Lt/d;

    aget-object v1, v1, p2

    move-object v7, v1

    :goto_4aa
    if-eqz v7, :cond_4b7

    iget v1, v7, Lt/d;->V:I

    const/16 v6, 0x8

    if-ne v1, v6, :cond_4b9

    iget-object v1, v7, Lt/d;->b0:[Lt/d;

    aget-object v7, v1, p2

    goto :goto_4aa

    :cond_4b7
    const/16 v6, 0x8

    :cond_4b9
    if-nez v7, :cond_4c6

    if-ne v13, v14, :cond_4be

    goto :goto_4c6

    :cond_4be
    move-object/from16 v22, v7

    move-object/from16 v35, v8

    move-object/from16 v20, v9

    goto/16 :goto_57d

    :cond_4c6
    :goto_4c6
    iget-object v1, v13, Lt/d;->F:[Lt/c;

    aget-object v2, v1, v15

    iget-object v3, v2, Lt/c;->g:Ls/k;

    iget-object v4, v2, Lt/c;->d:Lt/c;

    if-eqz v4, :cond_4d3

    iget-object v4, v4, Lt/c;->g:Ls/k;

    goto :goto_4d5

    :cond_4d3
    move-object/from16 v4, v16

    :goto_4d5
    if-eq v9, v13, :cond_4e0

    iget-object v4, v9, Lt/d;->F:[Lt/c;

    add-int/lit8 v5, v15, 0x1

    aget-object v4, v4, v5

    iget-object v4, v4, Lt/c;->g:Ls/k;

    goto :goto_4f1

    :cond_4e0
    if-ne v13, v0, :cond_4f1

    if-ne v9, v13, :cond_4f1

    iget-object v4, v8, Lt/d;->F:[Lt/c;

    aget-object v4, v4, v15

    iget-object v4, v4, Lt/c;->d:Lt/c;

    if-eqz v4, :cond_4ef

    iget-object v4, v4, Lt/c;->g:Ls/k;

    goto :goto_4f1

    :cond_4ef
    move-object/from16 v4, v16

    :cond_4f1
    :goto_4f1
    invoke-virtual {v2}, Lt/c;->c()I

    move-result v2

    add-int/lit8 v5, v15, 0x1

    aget-object v20, v1, v5

    invoke-virtual/range {v20 .. v20}, Lt/c;->c()I

    move-result v20

    if-eqz v7, :cond_50e

    iget-object v6, v7, Lt/d;->F:[Lt/c;

    aget-object v6, v6, v15

    move-object/from16 v23, v7

    iget-object v7, v6, Lt/c;->g:Ls/k;

    aget-object v1, v1, v5

    iget-object v1, v1, Lt/c;->g:Ls/k;

    :goto_50b
    move-object/from16 v24, v1

    goto :goto_522

    :cond_50e
    move-object/from16 v23, v7

    iget-object v6, v11, Lt/d;->F:[Lt/c;

    aget-object v6, v6, v5

    iget-object v6, v6, Lt/c;->d:Lt/c;

    if-eqz v6, :cond_51b

    iget-object v7, v6, Lt/c;->g:Ls/k;

    goto :goto_51d

    :cond_51b
    move-object/from16 v7, v16

    :goto_51d
    aget-object v1, v1, v5

    iget-object v1, v1, Lt/c;->g:Ls/k;

    goto :goto_50b

    :goto_522
    if-eqz v6, :cond_52a

    invoke-virtual {v6}, Lt/c;->c()I

    move-result v1

    add-int v20, v1, v20

    :cond_52a
    if-eqz v9, :cond_535

    iget-object v1, v9, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v5

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    add-int/2addr v2, v1

    :cond_535
    if-eqz v3, :cond_577

    if-eqz v4, :cond_577

    if-eqz v7, :cond_577

    if-eqz v24, :cond_577

    if-ne v13, v0, :cond_549

    iget-object v1, v0, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v15

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    move v6, v1

    goto :goto_54a

    :cond_549
    move v6, v2

    :goto_54a
    if-ne v13, v14, :cond_556

    iget-object v1, v14, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v5

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    move/from16 v20, v1

    :cond_556
    if-eqz v21, :cond_55b

    const/16 v25, 0x8

    goto :goto_55d

    :cond_55b
    const/16 v25, 0x5

    :goto_55d
    const/high16 v5, 0x3f000000    # 0.5f

    move-object/from16 v1, p1

    move-object v2, v3

    move-object v3, v4

    move v4, v6

    const/16 v22, 0x8

    move-object v6, v7

    move-object/from16 v22, v23

    move-object/from16 v7, v24

    move-object/from16 v35, v8

    move/from16 v8, v20

    move-object/from16 v20, v9

    move/from16 v9, v25

    invoke-virtual/range {v1 .. v9}, Ls/e;->b(Ls/k;Ls/k;IFLs/k;Ls/k;II)V

    goto :goto_57d

    :cond_577
    move-object/from16 v35, v8

    move-object/from16 v20, v9

    move-object/from16 v22, v23

    :goto_57d
    iget v1, v13, Lt/d;->V:I

    const/16 v9, 0x8

    if-eq v1, v9, :cond_584

    goto :goto_586

    :cond_584
    move-object/from16 v13, v20

    :goto_586
    move-object v9, v13

    move-object/from16 v13, v22

    move-object/from16 v8, v35

    goto/16 :goto_4a3

    :cond_58d
    move-object/from16 v35, v8

    const/16 v9, 0x8

    if-eqz v17, :cond_485

    if-eqz v0, :cond_485

    iget v2, v1, Lt/b;->j:I

    if-lez v2, :cond_5a0

    iget v1, v1, Lt/b;->i:I

    if-ne v1, v2, :cond_5a0

    const/16 v21, 0x1

    goto :goto_5a2

    :cond_5a0
    move/from16 v21, v18

    :goto_5a2
    move-object v8, v0

    move-object v13, v8

    :goto_5a4
    if-eqz v13, :cond_65b

    iget-object v1, v13, Lt/d;->b0:[Lt/d;

    aget-object v1, v1, p2

    :goto_5aa
    if-eqz v1, :cond_5b5

    iget v2, v1, Lt/d;->V:I

    if-ne v2, v9, :cond_5b5

    iget-object v1, v1, Lt/d;->b0:[Lt/d;

    aget-object v1, v1, p2

    goto :goto_5aa

    :cond_5b5
    if-eq v13, v0, :cond_648

    if-eq v13, v14, :cond_648

    if-eqz v1, :cond_648

    if-ne v1, v14, :cond_5c0

    move-object/from16 v7, v16

    goto :goto_5c1

    :cond_5c0
    move-object v7, v1

    :goto_5c1
    iget-object v1, v13, Lt/d;->F:[Lt/c;

    aget-object v2, v1, v15

    iget-object v3, v2, Lt/c;->g:Ls/k;

    iget-object v4, v8, Lt/d;->F:[Lt/c;

    add-int/lit8 v5, v15, 0x1

    aget-object v4, v4, v5

    iget-object v4, v4, Lt/c;->g:Ls/k;

    invoke-virtual {v2}, Lt/c;->c()I

    move-result v2

    aget-object v6, v1, v5

    invoke-virtual {v6}, Lt/c;->c()I

    move-result v6

    if-eqz v7, :cond_5ed

    iget-object v1, v7, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v15

    iget-object v9, v1, Lt/c;->g:Ls/k;

    move-object/from16 v20, v7

    iget-object v7, v1, Lt/c;->d:Lt/c;

    if-eqz v7, :cond_5ea

    iget-object v7, v7, Lt/c;->g:Ls/k;

    goto :goto_603

    :cond_5ea
    move-object/from16 v7, v16

    goto :goto_603

    :cond_5ed
    move-object/from16 v20, v7

    iget-object v7, v14, Lt/d;->F:[Lt/c;

    aget-object v7, v7, v15

    if-eqz v7, :cond_5f8

    iget-object v9, v7, Lt/c;->g:Ls/k;

    goto :goto_5fa

    :cond_5f8
    move-object/from16 v9, v16

    :goto_5fa
    aget-object v1, v1, v5

    iget-object v1, v1, Lt/c;->g:Ls/k;

    move-object/from16 v36, v7

    move-object v7, v1

    move-object/from16 v1, v36

    :goto_603
    if-eqz v1, :cond_60d

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    add-int/2addr v1, v6

    move/from16 v22, v1

    goto :goto_60f

    :cond_60d
    move/from16 v22, v6

    :goto_60f
    iget-object v1, v8, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v5

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    add-int v5, v1, v2

    if-eqz v21, :cond_61e

    const/16 v24, 0x8

    goto :goto_620

    :cond_61e
    move/from16 v24, v23

    :goto_620
    if-eqz v3, :cond_63f

    if-eqz v4, :cond_63f

    if-eqz v9, :cond_63f

    if-eqz v7, :cond_63f

    const/high16 v6, 0x3f000000    # 0.5f

    move-object/from16 v1, p1

    move-object v2, v3

    move-object v3, v4

    move v4, v5

    move v5, v6

    move-object v6, v9

    move-object/from16 v25, v8

    move/from16 v8, v22

    move/from16 v22, v12

    const/16 v12, 0x8

    move/from16 v9, v24

    invoke-virtual/range {v1 .. v9}, Ls/e;->b(Ls/k;Ls/k;IFLs/k;Ls/k;II)V

    goto :goto_645

    :cond_63f
    move-object/from16 v25, v8

    move/from16 v22, v12

    const/16 v12, 0x8

    :goto_645
    move-object/from16 v1, v20

    goto :goto_64d

    :cond_648
    move-object/from16 v25, v8

    move/from16 v22, v12

    move v12, v9

    :goto_64d
    iget v2, v13, Lt/d;->V:I

    if-eq v2, v12, :cond_653

    move-object v8, v13

    goto :goto_655

    :cond_653
    move-object/from16 v8, v25

    :goto_655
    move-object v13, v1

    move v9, v12

    move/from16 v12, v22

    goto/16 :goto_5a4

    :cond_65b
    move/from16 v22, v12

    iget-object v1, v0, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v15

    move-object/from16 v2, v35

    iget-object v2, v2, Lt/d;->F:[Lt/c;

    aget-object v2, v2, v15

    iget-object v2, v2, Lt/c;->d:Lt/c;

    iget-object v3, v14, Lt/d;->F:[Lt/c;

    add-int/lit8 v4, v15, 0x1

    aget-object v12, v3, v4

    iget-object v3, v11, Lt/d;->F:[Lt/c;

    aget-object v3, v3, v4

    iget-object v13, v3, Lt/c;->d:Lt/c;

    const/4 v9, 0x5

    if-eqz v2, :cond_685

    if-eq v0, v14, :cond_688

    iget-object v3, v1, Lt/c;->g:Ls/k;

    iget-object v2, v2, Lt/c;->g:Ls/k;

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v1

    invoke-virtual {v10, v3, v2, v1, v9}, Ls/e;->e(Ls/k;Ls/k;II)V

    :cond_685
    move/from16 v20, v9

    goto :goto_6a8

    :cond_688
    if-eqz v13, :cond_685

    iget-object v3, v1, Lt/c;->g:Ls/k;

    iget-object v4, v2, Lt/c;->g:Ls/k;

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v5

    iget-object v6, v12, Lt/c;->g:Ls/k;

    iget-object v7, v13, Lt/c;->g:Ls/k;

    invoke-virtual {v12}, Lt/c;->c()I

    move-result v8

    const/high16 v20, 0x3f000000    # 0.5f

    move-object/from16 v1, p1

    move-object v2, v3

    move-object v3, v4

    move v4, v5

    move/from16 v5, v20

    move/from16 v20, v9

    invoke-virtual/range {v1 .. v9}, Ls/e;->b(Ls/k;Ls/k;IFLs/k;Ls/k;II)V

    :goto_6a8
    if-eqz v13, :cond_6ba

    if-eq v0, v14, :cond_6ba

    iget-object v1, v12, Lt/c;->g:Ls/k;

    iget-object v2, v13, Lt/c;->g:Ls/k;

    invoke-virtual {v12}, Lt/c;->c()I

    move-result v3

    neg-int v3, v3

    move/from16 v4, v20

    invoke-virtual {v10, v1, v2, v3, v4}, Ls/e;->e(Ls/k;Ls/k;II)V

    :cond_6ba
    :goto_6ba
    if-nez v19, :cond_6be

    if-eqz v17, :cond_711

    :cond_6be
    if-eqz v0, :cond_711

    if-eq v0, v14, :cond_711

    iget-object v1, v0, Lt/d;->F:[Lt/c;

    aget-object v2, v1, v15

    iget-object v3, v14, Lt/d;->F:[Lt/c;

    add-int/lit8 v4, v15, 0x1

    aget-object v3, v3, v4

    iget-object v5, v2, Lt/c;->d:Lt/c;

    if-eqz v5, :cond_6d3

    iget-object v5, v5, Lt/c;->g:Ls/k;

    goto :goto_6d5

    :cond_6d3
    move-object/from16 v5, v16

    :goto_6d5
    iget-object v6, v3, Lt/c;->d:Lt/c;

    if-eqz v6, :cond_6dc

    iget-object v6, v6, Lt/c;->g:Ls/k;

    goto :goto_6de

    :cond_6dc
    move-object/from16 v6, v16

    :goto_6de
    if-eq v11, v14, :cond_6ee

    iget-object v6, v11, Lt/d;->F:[Lt/c;

    aget-object v6, v6, v4

    iget-object v6, v6, Lt/c;->d:Lt/c;

    if-eqz v6, :cond_6ec

    iget-object v6, v6, Lt/c;->g:Ls/k;

    move-object/from16 v16, v6

    :cond_6ec
    move-object/from16 v6, v16

    :cond_6ee
    if-ne v0, v14, :cond_6f2

    aget-object v3, v1, v4

    :cond_6f2
    if-eqz v5, :cond_711

    if-eqz v6, :cond_711

    invoke-virtual {v2}, Lt/c;->c()I

    move-result v0

    iget-object v1, v14, Lt/d;->F:[Lt/c;

    aget-object v1, v1, v4

    invoke-virtual {v1}, Lt/c;->c()I

    move-result v8

    iget-object v2, v2, Lt/c;->g:Ls/k;

    iget-object v7, v3, Lt/c;->g:Ls/k;

    const/4 v9, 0x5

    const/high16 v11, 0x3f000000    # 0.5f

    move-object/from16 v1, p1

    move-object v3, v5

    move v4, v0

    move v5, v11

    invoke-virtual/range {v1 .. v9}, Ls/e;->b(Ls/k;Ls/k;IFLs/k;Ls/k;II)V

    :cond_711
    add-int/lit8 v9, v22, 0x1

    const/4 v11, 0x2

    move-object/from16 v0, p0

    move/from16 v13, v26

    move-object/from16 v14, v30

    goto/16 :goto_17

    :cond_71c
    return-void
.end method

.method public static final c(Lg3/l;Ljava/lang/Object;Lw2/h;)Lw2/h;
    .registers 5

    :try_start_0
    invoke-interface {p0, p1}, Lg3/l;->i(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_4

    goto :goto_10

    :catchall_4
    move-exception p0

    if-eqz p2, :cond_11

    invoke-virtual {p2}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object v0

    if-eq v0, p0, :cond_11

    invoke-static {p2, p0}, Ld3/b;->i(Ljava/lang/Throwable;Ljava/lang/Throwable;)V

    :goto_10
    return-object p2

    :cond_11
    new-instance p2, Lw2/h;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Exception in undelivered element handler for "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1, p0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-object p2
.end method

.method public static d([Lc0/f;[Lc0/f;)Z
    .registers 8

    const/4 v0, 0x0

    if-eqz p0, :cond_28

    if-nez p1, :cond_6

    goto :goto_28

    :cond_6
    array-length v1, p0

    array-length v2, p1

    if-eq v1, v2, :cond_b

    return v0

    :cond_b
    move v1, v0

    :goto_c
    array-length v2, p0

    if-ge v1, v2, :cond_26

    aget-object v2, p0, v1

    iget-char v3, v2, Lc0/f;->a:C

    aget-object v4, p1, v1

    iget-char v5, v4, Lc0/f;->a:C

    if-ne v3, v5, :cond_25

    iget-object v2, v2, Lc0/f;->b:[F

    array-length v2, v2

    iget-object v3, v4, Lc0/f;->b:[F

    array-length v3, v3

    if-eq v2, v3, :cond_22

    goto :goto_25

    :cond_22
    add-int/lit8 v1, v1, 0x1

    goto :goto_c

    :cond_25
    :goto_25
    return v0

    :cond_26
    const/4 p0, 0x1

    return p0

    :cond_28
    :goto_28
    return v0
.end method

.method public static e(Landroid/content/Context;Ljava/lang/String;)I
    .registers 8

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, p1, v0, v1}, Landroid/content/Context;->checkPermission(Ljava/lang/String;II)I

    move-result v0

    const/4 v3, -0x1

    if-ne v0, v3, :cond_15

    goto/16 :goto_7a

    :cond_15
    invoke-static {p1}, Lz/h;->d(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    const/4 v0, 0x0

    if-nez p1, :cond_1e

    :goto_1c
    move v3, v0

    goto :goto_7a

    :cond_1e
    if-nez v2, :cond_30

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/pm/PackageManager;->getPackagesForUid(I)[Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_7a

    array-length v4, v2

    if-gtz v4, :cond_2e

    goto :goto_7a

    :cond_2e
    aget-object v2, v2, v0

    :cond_30
    invoke-static {}, Landroid/os/Process;->myUid()I

    move-result v3

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    const-class v5, Landroid/app/AppOpsManager;

    if-ne v3, v1, :cond_6b

    invoke-static {v4, v2}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_6b

    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x1d

    if-lt v3, v4, :cond_60

    invoke-static {p0}, Lz/i;->c(Landroid/content/Context;)Landroid/app/AppOpsManager;

    move-result-object v3

    invoke-static {}, Landroid/os/Binder;->getCallingUid()I

    move-result v4

    invoke-static {v3, p1, v4, v2}, Lz/i;->a(Landroid/app/AppOpsManager;Ljava/lang/String;ILjava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_57

    goto :goto_75

    :cond_57
    invoke-static {p0}, Lz/i;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p0

    invoke-static {v3, p1, v1, p0}, Lz/i;->a(Landroid/app/AppOpsManager;Ljava/lang/String;ILjava/lang/String;)I

    move-result v2

    goto :goto_75

    :cond_60
    invoke-static {p0, v5}, Lz/h;->a(Landroid/content/Context;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/AppOpsManager;

    invoke-static {p0, p1, v2}, Lz/h;->c(Landroid/app/AppOpsManager;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    goto :goto_75

    :cond_6b
    invoke-static {p0, v5}, Lz/h;->a(Landroid/content/Context;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/app/AppOpsManager;

    invoke-static {p0, p1, v2}, Lz/h;->c(Landroid/app/AppOpsManager;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    :goto_75
    if-nez v2, :cond_78

    goto :goto_1c

    :cond_78
    const/4 p0, -0x2

    move v3, p0

    :cond_7a
    :goto_7a
    return v3
.end method

.method public static f(Ljava/io/Closeable;)V
    .registers 1

    if-eqz p0, :cond_5

    :try_start_2
    invoke-interface {p0}, Ljava/io/Closeable;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_5} :catch_5

    :catch_5
    :cond_5
    return-void
.end method

.method public static g([FI)[F
    .registers 4

    if-ltz p1, :cond_16

    array-length v0, p0

    if-ltz v0, :cond_10

    invoke-static {p1, v0}, Ljava/lang/Math;->min(II)I

    move-result v0

    new-array p1, p1, [F

    const/4 v1, 0x0

    invoke-static {p0, v1, p1, v1, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    return-object p1

    :cond_10
    new-instance p0, Ljava/lang/ArrayIndexOutOfBoundsException;

    invoke-direct {p0}, Ljava/lang/ArrayIndexOutOfBoundsException;-><init>()V

    throw p0

    :cond_16
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p0
.end method

.method public static h(Ljava/io/File;Landroid/content/res/Resources;I)Z
    .registers 3

    :try_start_0
    invoke-virtual {p1, p2}, Landroid/content/res/Resources;->openRawResource(I)Ljava/io/InputStream;

    move-result-object p1
    :try_end_4
    .catchall {:try_start_0 .. :try_end_4} :catchall_e

    :try_start_4
    invoke-static {p0, p1}, Lp3/y;->i(Ljava/io/File;Ljava/io/InputStream;)Z

    move-result p0
    :try_end_8
    .catchall {:try_start_4 .. :try_end_8} :catchall_c

    invoke-static {p1}, Lp3/y;->f(Ljava/io/Closeable;)V

    return p0

    :catchall_c
    move-exception p0

    goto :goto_10

    :catchall_e
    move-exception p0

    const/4 p1, 0x0

    :goto_10
    invoke-static {p1}, Lp3/y;->f(Ljava/io/Closeable;)V

    throw p0
.end method

.method public static i(Ljava/io/File;Ljava/io/InputStream;)Z
    .registers 7

    invoke-static {}, Landroid/os/StrictMode;->allowThreadDiskWrites()Landroid/os/StrictMode$ThreadPolicy;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_6
    new-instance v3, Ljava/io/FileOutputStream;

    invoke-direct {v3, p0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_b} :catch_2a
    .catchall {:try_start_6 .. :try_end_b} :catchall_28

    const/16 p0, 0x400

    :try_start_d
    new-array p0, p0, [B

    :goto_f
    invoke-virtual {p1, p0}, Ljava/io/InputStream;->read([B)I

    move-result v2

    const/4 v4, -0x1

    if-eq v2, v4, :cond_20

    invoke-virtual {v3, p0, v1, v2}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_19
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_19} :catch_1d
    .catchall {:try_start_d .. :try_end_19} :catchall_1a

    goto :goto_f

    :catchall_1a
    move-exception p0

    move-object v2, v3

    goto :goto_4c

    :catch_1d
    move-exception p0

    move-object v2, v3

    goto :goto_2b

    :cond_20
    invoke-static {v3}, Lp3/y;->f(Ljava/io/Closeable;)V

    invoke-static {v0}, Landroid/os/StrictMode;->setThreadPolicy(Landroid/os/StrictMode$ThreadPolicy;)V

    const/4 p0, 0x1

    return p0

    :catchall_28
    move-exception p0

    goto :goto_4c

    :catch_2a
    move-exception p0

    :goto_2b
    :try_start_2b
    const-string p1, "TypefaceCompatUtil"

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Error copying resource contents to temp file: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_45
    .catchall {:try_start_2b .. :try_end_45} :catchall_28

    invoke-static {v2}, Lp3/y;->f(Ljava/io/Closeable;)V

    invoke-static {v0}, Landroid/os/StrictMode;->setThreadPolicy(Landroid/os/StrictMode$ThreadPolicy;)V

    return v1

    :goto_4c
    invoke-static {v2}, Lp3/y;->f(Ljava/io/Closeable;)V

    invoke-static {v0}, Landroid/os/StrictMode;->setThreadPolicy(Landroid/os/StrictMode$ThreadPolicy;)V

    throw p0
.end method

.method public static j(Ljava/lang/String;)[Lc0/f;
    .registers 18

    move-object/from16 v0, p0

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    move v5, v2

    const/4 v4, 0x1

    :goto_a
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v4, v6, :cond_e9

    :goto_10
    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->length()I

    move-result v6

    const/16 v7, 0x45

    const/16 v8, 0x65

    if-ge v4, v6, :cond_34

    invoke-virtual {v0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v6

    add-int/lit8 v9, v6, -0x41

    add-int/lit8 v10, v6, -0x5a

    mul-int/2addr v10, v9

    if-lez v10, :cond_2c

    add-int/lit8 v9, v6, -0x61

    add-int/lit8 v10, v6, -0x7a

    mul-int/2addr v10, v9

    if-gtz v10, :cond_31

    :cond_2c
    if-eq v6, v8, :cond_31

    if-eq v6, v7, :cond_31

    goto :goto_34

    :cond_31
    add-int/lit8 v4, v4, 0x1

    goto :goto_10

    :cond_34
    :goto_34
    invoke-virtual {v0, v5, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_e2

    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v6

    const/16 v9, 0x7a

    if-eq v6, v9, :cond_d4

    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v6

    const/16 v9, 0x5a

    if-ne v6, v9, :cond_54

    goto/16 :goto_d4

    :cond_54
    :try_start_54
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v6

    new-array v6, v6, [F

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v9

    move v11, v2

    const/4 v10, 0x1

    :goto_60
    if-ge v10, v9, :cond_b4

    move v13, v2

    move v14, v13

    move v15, v14

    move/from16 v16, v15

    move v12, v10

    :goto_68
    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v12, v3, :cond_9a

    invoke-virtual {v5, v12}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v2, 0x20

    if-eq v3, v2, :cond_91

    if-eq v3, v7, :cond_8f

    if-eq v3, v8, :cond_8f

    packed-switch v3, :pswitch_data_10e

    goto :goto_8d

    :pswitch_7e
    if-nez v14, :cond_83

    const/4 v13, 0x0

    const/4 v14, 0x1

    goto :goto_93

    :cond_83
    :goto_83
    const/4 v13, 0x0

    const/4 v15, 0x1

    const/16 v16, 0x1

    goto :goto_93

    :pswitch_88
    if-eq v12, v10, :cond_8d

    if-nez v13, :cond_8d

    goto :goto_83

    :cond_8d
    :goto_8d
    const/4 v13, 0x0

    goto :goto_93

    :cond_8f
    const/4 v13, 0x1

    goto :goto_93

    :cond_91
    :pswitch_91
    const/4 v13, 0x0

    const/4 v15, 0x1

    :goto_93
    if-eqz v15, :cond_96

    goto :goto_9a

    :cond_96
    add-int/lit8 v12, v12, 0x1

    const/4 v2, 0x0

    goto :goto_68

    :cond_9a
    :goto_9a
    if-ge v10, v12, :cond_ac

    add-int/lit8 v2, v11, 0x1

    invoke-virtual {v5, v10, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F

    move-result v3

    aput v3, v6, v11

    move v11, v2

    goto :goto_ac

    :catch_aa
    move-exception v0

    goto :goto_bb

    :cond_ac
    :goto_ac
    if-eqz v16, :cond_b1

    move v10, v12

    :goto_af
    const/4 v2, 0x0

    goto :goto_60

    :cond_b1
    add-int/lit8 v10, v12, 0x1

    goto :goto_af

    :cond_b4
    invoke-static {v6, v11}, Lp3/y;->g([FI)[F

    move-result-object v2
    :try_end_b8
    .catch Ljava/lang/NumberFormatException; {:try_start_54 .. :try_end_b8} :catch_aa

    move-object v3, v2

    const/4 v2, 0x0

    goto :goto_d6

    :goto_bb
    new-instance v1, Ljava/lang/RuntimeException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "error in parsing \""

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "\""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1

    :cond_d4
    :goto_d4
    new-array v3, v2, [F

    :goto_d6
    invoke-virtual {v5, v2}, Ljava/lang/String;->charAt(I)C

    move-result v5

    new-instance v2, Lc0/f;

    invoke-direct {v2, v5, v3}, Lc0/f;-><init>(C[F)V

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_e2
    add-int/lit8 v2, v4, 0x1

    move v5, v4

    move v4, v2

    const/4 v2, 0x0

    goto/16 :goto_a

    :cond_e9
    sub-int/2addr v4, v5

    const/4 v2, 0x1

    if-ne v4, v2, :cond_103

    invoke-virtual/range {p0 .. p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v5, v2, :cond_103

    invoke-virtual {v0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/4 v2, 0x0

    new-array v3, v2, [F

    new-instance v4, Lc0/f;

    invoke-direct {v4, v0, v3}, Lc0/f;-><init>(C[F)V

    invoke-virtual {v1, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_104

    :cond_103
    const/4 v2, 0x0

    :goto_104
    new-array v0, v2, [Lc0/f;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lc0/f;

    return-object v0

    nop

    :pswitch_data_10e
    .packed-switch 0x2c
        :pswitch_91
        :pswitch_88
        :pswitch_7e
    .end packed-switch
.end method

.method public static k(Ljava/lang/String;)Landroid/graphics/Path;
    .registers 4

    new-instance v0, Landroid/graphics/Path;

    invoke-direct {v0}, Landroid/graphics/Path;-><init>()V

    invoke-static {p0}, Lp3/y;->j(Ljava/lang/String;)[Lc0/f;

    move-result-object v1

    :try_start_9
    invoke-static {v1, v0}, Lc0/f;->b([Lc0/f;Landroid/graphics/Path;)V
    :try_end_c
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_c} :catch_d

    return-object v0

    :catch_d
    move-exception v0

    new-instance v1, Ljava/lang/RuntimeException;

    const-string v2, "Error in parsing "

    invoke-virtual {v2, p0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-direct {v1, p0, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static l([Lc0/f;)[Lc0/f;
    .registers 5

    array-length v0, p0

    new-array v0, v0, [Lc0/f;

    const/4 v1, 0x0

    :goto_4
    array-length v2, p0

    if-ge v1, v2, :cond_13

    new-instance v2, Lc0/f;

    aget-object v3, p0, v1

    invoke-direct {v2, v3}, Lc0/f;-><init>(Lc0/f;)V

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    :cond_13
    return-object v0
.end method

.method public static final m(Ls3/e;)Ls3/e;
    .registers 5

    instance-of v0, p0, Ls3/o0;

    if-eqz v0, :cond_5

    goto :goto_1f

    :cond_5
    sget-object v0, Ls3/j;->d:Ls3/j;

    sget-object v1, Ls3/i;->d:Ls3/i;

    instance-of v2, p0, Ls3/d;

    if-eqz v2, :cond_19

    move-object v2, p0

    check-cast v2, Ls3/d;

    iget-object v3, v2, Ls3/d;->d:Lg3/l;

    if-ne v3, v0, :cond_19

    iget-object v0, v2, Ls3/d;->e:Lg3/p;

    if-ne v0, v1, :cond_19

    goto :goto_1f

    :cond_19
    new-instance v0, Ls3/d;

    invoke-direct {v0, p0}, Ls3/d;-><init>(Ls3/e;)V

    move-object p0, v0

    :goto_1f
    return-object p0
.end method

.method public static final n(Ls3/f;Lr3/j;ZLz2/e;)Ljava/lang/Object;
    .registers 11

    instance-of v0, p3, Ls3/h;

    if-eqz v0, :cond_13

    move-object v0, p3

    check-cast v0, Ls3/h;

    iget v1, v0, Ls3/h;->h:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_13

    sub-int/2addr v1, v2

    iput v1, v0, Ls3/h;->h:I

    goto :goto_18

    :cond_13
    new-instance v0, Ls3/h;

    invoke-direct {v0, p3}, Lb3/c;-><init>(Lz2/e;)V

    :goto_18
    iget-object p3, v0, Ls3/h;->g:Ljava/lang/Object;

    sget-object v1, La3/a;->c:La3/a;

    iget v2, v0, Ls3/h;->h:I

    const/4 v3, 0x0

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-eqz v2, :cond_4b

    if-eq v2, v5, :cond_3f

    if-ne v2, v4, :cond_37

    iget-boolean p2, v0, Ls3/h;->f:Z

    iget-object p0, v0, Ls3/h;->e:Lr3/b;

    iget-object p1, v0, Ls3/h;->d:Lr3/u;

    iget-object v2, v0, Ls3/h;->c:Ls3/f;

    :try_start_2f
    invoke-static {p3}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_32
    .catchall {:try_start_2f .. :try_end_32} :catchall_35

    :cond_32
    move-object p3, p0

    move-object p0, v2

    goto :goto_52

    :catchall_35
    move-exception p0

    goto :goto_8c

    :cond_37
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_3f
    iget-boolean p2, v0, Ls3/h;->f:Z

    iget-object p0, v0, Ls3/h;->e:Lr3/b;

    iget-object p1, v0, Ls3/h;->d:Lr3/u;

    iget-object v2, v0, Ls3/h;->c:Ls3/f;

    :try_start_47
    invoke-static {p3}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_4a
    .catchall {:try_start_47 .. :try_end_4a} :catchall_35

    goto :goto_67

    :cond_4b
    invoke-static {p3}, Ld3/b;->Y1(Ljava/lang/Object;)V

    :try_start_4e
    invoke-interface {p1}, Lr3/u;->iterator()Lr3/b;

    move-result-object p3

    :goto_52
    iput-object p0, v0, Ls3/h;->c:Ls3/f;

    iput-object p1, v0, Ls3/h;->d:Lr3/u;

    iput-object p3, v0, Ls3/h;->e:Lr3/b;

    iput-boolean p2, v0, Ls3/h;->f:Z

    iput v5, v0, Ls3/h;->h:I

    invoke-virtual {p3, v0}, Lr3/b;->b(Lz2/e;)Ljava/lang/Object;

    move-result-object v2

    if-ne v2, v1, :cond_63

    return-object v1

    :cond_63
    move-object v6, v2

    move-object v2, p0

    move-object p0, p3

    move-object p3, v6

    :goto_67
    check-cast p3, Ljava/lang/Boolean;

    invoke-virtual {p3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p3

    if-eqz p3, :cond_84

    invoke-virtual {p0}, Lr3/b;->c()Ljava/lang/Object;

    move-result-object p3

    iput-object v2, v0, Ls3/h;->c:Ls3/f;

    iput-object p1, v0, Ls3/h;->d:Lr3/u;

    iput-object p0, v0, Ls3/h;->e:Lr3/b;

    iput-boolean p2, v0, Ls3/h;->f:Z

    iput v4, v0, Ls3/h;->h:I

    invoke-interface {v2, p3, v0}, Ls3/f;->b(Ljava/lang/Object;Lz2/e;)Ljava/lang/Object;

    move-result-object p3
    :try_end_81
    .catchall {:try_start_4e .. :try_end_81} :catchall_35

    if-ne p3, v1, :cond_32

    return-object v1

    :cond_84
    if-eqz p2, :cond_89

    invoke-interface {p1, v3}, Lr3/u;->a(Ljava/util/concurrent/CancellationException;)V

    :cond_89
    sget-object p0, Lw2/i;->a:Lw2/i;

    return-object p0

    :goto_8c
    :try_start_8c
    throw p0
    :try_end_8d
    .catchall {:try_start_8c .. :try_end_8d} :catchall_8d

    :catchall_8d
    move-exception p3

    if-eqz p2, :cond_a6

    instance-of p2, p0, Ljava/util/concurrent/CancellationException;

    if-eqz p2, :cond_97

    move-object v3, p0

    check-cast v3, Ljava/util/concurrent/CancellationException;

    :cond_97
    if-nez v3, :cond_a3

    new-instance v3, Ljava/util/concurrent/CancellationException;

    const-string p2, "Channel was consumed, consumer had failed"

    invoke-direct {v3, p2}, Ljava/util/concurrent/CancellationException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p0}, Ljava/lang/Throwable;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    :cond_a3
    invoke-interface {p1, v3}, Lr3/u;->a(Ljava/util/concurrent/CancellationException;)V

    :cond_a6
    throw p3
.end method

.method public static final o(Lt3/f0;Ls3/s;Lz2/e;)Ljava/lang/Object;
    .registers 8

    instance-of v0, p2, Ls3/r;

    if-eqz v0, :cond_13

    move-object v0, p2

    check-cast v0, Ls3/r;

    iget v1, v0, Ls3/r;->g:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_13

    sub-int/2addr v1, v2

    iput v1, v0, Ls3/r;->g:I

    goto :goto_18

    :cond_13
    new-instance v0, Ls3/r;

    invoke-direct {v0, p2}, Lb3/c;-><init>(Lz2/e;)V

    :goto_18
    iget-object p2, v0, Ls3/r;->f:Ljava/lang/Object;

    sget-object v1, La3/a;->c:La3/a;

    iget v2, v0, Ls3/r;->g:I

    sget-object v3, Lt3/c;->b:Lu0/t;

    const/4 v4, 0x1

    if-eqz v2, :cond_39

    if-ne v2, v4, :cond_31

    iget-object p0, v0, Ls3/r;->e:Ls3/q;

    iget-object p1, v0, Ls3/r;->d:Lh3/m;

    iget-object v0, v0, Ls3/r;->c:Lg3/p;

    :try_start_2b
    invoke-static {p2}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_2e
    .catch Lt3/a; {:try_start_2b .. :try_end_2e} :catch_2f

    goto :goto_5f

    :catch_2f
    move-exception p2

    goto :goto_5b

    :cond_31
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_39
    invoke-static {p2}, Ld3/b;->Y1(Ljava/lang/Object;)V

    new-instance p2, Lh3/m;

    invoke-direct {p2}, Ljava/lang/Object;-><init>()V

    iput-object v3, p2, Lh3/m;->c:Ljava/lang/Object;

    new-instance v2, Ls3/q;

    invoke-direct {v2, p1, p2}, Ls3/q;-><init>(Ls3/s;Lh3/m;)V

    :try_start_48
    iput-object p1, v0, Ls3/r;->c:Lg3/p;

    iput-object p2, v0, Ls3/r;->d:Lh3/m;

    iput-object v2, v0, Ls3/r;->e:Ls3/q;

    iput v4, v0, Ls3/r;->g:I

    invoke-virtual {p0, v2, v0}, Lt3/f0;->c(Ls3/f;Lz2/e;)Ljava/lang/Object;
    :try_end_53
    .catch Lt3/a; {:try_start_48 .. :try_end_53} :catch_59

    goto :goto_63

    :goto_54
    move-object v0, p1

    move-object p1, p2

    move-object p2, p0

    move-object p0, v2

    goto :goto_5b

    :catch_59
    move-exception p0

    goto :goto_54

    :goto_5b
    iget-object v1, p2, Lt3/a;->c:Ljava/lang/Object;

    if-ne v1, p0, :cond_78

    :goto_5f
    iget-object v1, p1, Lh3/m;->c:Ljava/lang/Object;

    if-eq v1, v3, :cond_64

    :goto_63
    return-object v1

    :cond_64
    new-instance p0, Ljava/util/NoSuchElementException;

    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "Expected at least one element matching the predicate "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/util/NoSuchElementException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_78
    throw p2
.end method

.method public static p(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;
    .registers 3

    invoke-static {}, Lk/q2;->c()Lk/q2;

    move-result-object v0

    invoke-virtual {v0, p0, p1}, Lk/q2;->e(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p0

    return-object p0
.end method

.method public static final q(Ljava/lang/Object;)Ljava/lang/String;
    .registers 1

    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result p0

    invoke-static {p0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static r(Landroid/content/res/TypedArray;Lorg/xmlpull/v1/XmlPullParser;Landroid/content/res/Resources$Theme;Ljava/lang/String;I)Landroidx/recyclerview/widget/n2;
    .registers 8

    invoke-static {p1, p3}, Lp3/y;->y(Lorg/xmlpull/v1/XmlPullParser;Ljava/lang/String;)Z

    move-result p1

    const/4 p3, 0x0

    const/4 v0, 0x0

    if-eqz p1, :cond_3b

    new-instance p1, Landroid/util/TypedValue;

    invoke-direct {p1}, Landroid/util/TypedValue;-><init>()V

    invoke-virtual {p0, p4, p1}, Landroid/content/res/TypedArray;->getValue(ILandroid/util/TypedValue;)Z

    iget v1, p1, Landroid/util/TypedValue;->type:I

    const/16 v2, 0x1c

    if-lt v1, v2, :cond_22

    const/16 v2, 0x1f

    if-gt v1, v2, :cond_22

    iget p0, p1, Landroid/util/TypedValue;->data:I

    new-instance p1, Landroidx/recyclerview/widget/n2;

    invoke-direct {p1, p3, p3, p0}, Landroidx/recyclerview/widget/n2;-><init>(Landroid/graphics/Shader;Landroid/content/res/ColorStateList;I)V

    return-object p1

    :cond_22
    invoke-virtual {p0}, Landroid/content/res/TypedArray;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p0, p4, v0}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result p0

    :try_start_2a
    invoke-static {p1, p0, p2}, Landroidx/recyclerview/widget/n2;->e(Landroid/content/res/Resources;ILandroid/content/res/Resources$Theme;)Landroidx/recyclerview/widget/n2;

    move-result-object p0
    :try_end_2e
    .catch Ljava/lang/Exception; {:try_start_2a .. :try_end_2e} :catch_2f

    goto :goto_38

    :catch_2f
    move-exception p0

    const-string p1, "ComplexColorCompat"

    const-string p2, "Failed to inflate ComplexColor."

    invoke-static {p1, p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    move-object p0, p3

    :goto_38
    if-eqz p0, :cond_3b

    return-object p0

    :cond_3b
    new-instance p0, Landroidx/recyclerview/widget/n2;

    invoke-direct {p0, p3, p3, v0}, Landroidx/recyclerview/widget/n2;-><init>(Landroid/graphics/Shader;Landroid/content/res/ColorStateList;I)V

    return-object p0
.end method

.method public static s(Landroid/app/Activity;)Landroid/content/Intent;
    .registers 4

    invoke-virtual {p0}, Landroid/app/Activity;->getParentActivityIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_7

    return-object v0

    :cond_7
    :try_start_7
    invoke-virtual {p0}, Landroid/app/Activity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v0

    invoke-static {p0, v0}, Lp3/y;->u(Landroid/content/Context;Landroid/content/ComponentName;)Ljava/lang/String;

    move-result-object v0
    :try_end_f
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_7 .. :try_end_f} :catch_46

    const/4 v1, 0x0

    if-nez v0, :cond_13

    return-object v1

    :cond_13
    new-instance v2, Landroid/content/ComponentName;

    invoke-direct {v2, p0, v0}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    :try_start_18
    invoke-static {p0, v2}, Lp3/y;->u(Landroid/content/Context;Landroid/content/ComponentName;)Ljava/lang/String;

    move-result-object p0

    if-nez p0, :cond_23

    invoke-static {v2}, Landroid/content/Intent;->makeMainActivity(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object p0

    goto :goto_2c

    :cond_23
    new-instance p0, Landroid/content/Intent;

    invoke-direct {p0}, Landroid/content/Intent;-><init>()V

    invoke-virtual {p0, v2}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object p0
    :try_end_2c
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_18 .. :try_end_2c} :catch_2d

    :goto_2c
    return-object p0

    :catch_2d
    new-instance p0, Ljava/lang/StringBuilder;

    const-string v2, "getParentActivityIntent: bad parentActivityName \'"

    invoke-direct {p0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "\' in manifest"

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    const-string v0, "NavUtils"

    invoke-static {v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v1

    :catch_46
    move-exception p0

    new-instance v0, Ljava/lang/IllegalArgumentException;

    invoke-direct {v0, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method public static t(Landroid/content/Context;Landroid/content/ComponentName;)Landroid/content/Intent;
    .registers 4

    invoke-static {p0, p1}, Lp3/y;->u(Landroid/content/Context;Landroid/content/ComponentName;)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_8

    const/4 p0, 0x0

    return-object p0

    :cond_8
    new-instance v1, Landroid/content/ComponentName;

    invoke-virtual {p1}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object p1

    invoke-direct {v1, p1, v0}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {p0, v1}, Lp3/y;->u(Landroid/content/Context;Landroid/content/ComponentName;)Ljava/lang/String;

    move-result-object p0

    if-nez p0, :cond_1c

    invoke-static {v1}, Landroid/content/Intent;->makeMainActivity(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object p0

    goto :goto_25

    :cond_1c
    new-instance p0, Landroid/content/Intent;

    invoke-direct {p0}, Landroid/content/Intent;-><init>()V

    invoke-virtual {p0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    move-result-object p0

    :goto_25
    return-object p0
.end method

.method public static u(Landroid/content/Context;Landroid/content/ComponentName;)Ljava/lang/String;
    .registers 5

    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_e

    const v1, 0x100c0280

    goto :goto_11

    :cond_e
    const v1, 0xc0280

    :goto_11
    invoke-virtual {v0, p1, v1}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object p1

    iget-object v0, p1, Landroid/content/pm/ActivityInfo;->parentActivityName:Ljava/lang/String;

    if-eqz v0, :cond_1a

    return-object v0

    :cond_1a
    iget-object p1, p1, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    const/4 v0, 0x0

    if-nez p1, :cond_20

    return-object v0

    :cond_20
    const-string v1, "android.support.PARENT_ACTIVITY"

    invoke-virtual {p1, v1}, Landroid/os/BaseBundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_29

    return-object v0

    :cond_29
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x2e

    if-ne v0, v1, :cond_45

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    :cond_45
    return-object p1
.end method

.method public static final v(Ljava/lang/Object;)Lu3/u;
    .registers 2

    sget-object v0, Lu3/a;->b:Lu0/t;

    if-eq p0, v0, :cond_7

    check-cast p0, Lu3/u;

    return-object p0

    :cond_7
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "Does not contain segment"

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static w(Landroid/content/Context;)Ljava/io/File;
    .registers 6

    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object p0

    const/4 v0, 0x0

    if-nez p0, :cond_8

    return-object v0

    :cond_8
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, ".font"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, "-"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Landroid/os/Process;->myTid()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    :goto_2a
    const/16 v3, 0x64

    if-ge v2, v3, :cond_4c

    new-instance v3, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, p0, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    :try_start_42
    invoke-virtual {v3}, Ljava/io/File;->createNewFile()Z

    move-result v4
    :try_end_46
    .catch Ljava/io/IOException; {:try_start_42 .. :try_end_46} :catch_49

    if-eqz v4, :cond_49

    return-object v3

    :catch_49
    :cond_49
    add-int/lit8 v2, v2, 0x1

    goto :goto_2a

    :cond_4c
    return-object v0
.end method

.method public static final x(Lz2/j;Ljava/lang/Throwable;)V
    .registers 6

    sget-object v0, Lu3/f;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_6
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_33

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lp3/u;

    :try_start_12
    check-cast v1, Lq3/b;

    invoke-virtual {v1, p0, p1}, Lq3/b;->v(Lz2/j;Ljava/lang/Throwable;)V
    :try_end_17
    .catchall {:try_start_12 .. :try_end_17} :catchall_18

    goto :goto_6

    :catchall_18
    move-exception v1

    if-ne p1, v1, :cond_1d

    move-object v2, p1

    goto :goto_27

    :cond_1d
    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "Exception while trying to handle coroutine exception"

    invoke-direct {v2, v3, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-static {v2, p1}, Ld3/b;->i(Ljava/lang/Throwable;Ljava/lang/Throwable;)V

    :goto_27
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->getUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;

    move-result-object v3

    invoke-interface {v3, v1, v2}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    goto :goto_6

    :cond_33
    :try_start_33
    new-instance v0, Lu3/g;

    invoke-direct {v0, p0}, Lu3/g;-><init>(Lz2/j;)V

    invoke-static {p1, v0}, Ld3/b;->i(Ljava/lang/Throwable;Ljava/lang/Throwable;)V
    :try_end_3b
    .catchall {:try_start_33 .. :try_end_3b} :catchall_3b

    :catchall_3b
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Thread;->getUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;

    move-result-object v0

    invoke-interface {v0, p0, p1}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V

    return-void
.end method

.method public static y(Lorg/xmlpull/v1/XmlPullParser;Ljava/lang/String;)Z
    .registers 3

    const-string v0, "http://schemas.android.com/apk/res/android"

    invoke-interface {p0, v0, p1}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    if-eqz p0, :cond_a

    const/4 p0, 0x1

    goto :goto_b

    :cond_a
    const/4 p0, 0x0

    :goto_b
    return p0
.end method

.method public static final z(Ljava/lang/Object;)Z
    .registers 2

    sget-object v0, Lu3/a;->b:Lu0/t;

    if-ne p0, v0, :cond_6

    const/4 p0, 0x1

    goto :goto_7

    :cond_6
    const/4 p0, 0x0

    :goto_7
    return p0
.end method
