.class public Lcom/librelink/app/CrashReportUtil;
.super Ljava/lang/Object;
.source "CrashReportUtil.java"

# interfaces
.implements Ljava/lang/Thread$UncaughtExceptionHandler;


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static setDefaultUncaughtExceptionHandler()V
    .registers 1

    .prologue
    .line 11
    new-instance v0, Lcom/librelink/app/CrashReportUtil;

    invoke-direct {v0}, Lcom/librelink/app/CrashReportUtil;-><init>()V

    invoke-static {v0}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V

    .line 12
    return-void
.end method


# virtual methods
.method public uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    .registers 13
    .param p1, "t"    # Ljava/lang/Thread;
    .param p2, "e"    # Ljava/lang/Throwable;

    .prologue
    .line 16
    new-instance v5, Ljava/io/StringWriter;

    invoke-direct {v5}, Ljava/io/StringWriter;-><init>()V

    .line 17
    .local v5, "writer":Ljava/io/Writer;
    new-instance v6, Ljava/io/PrintWriter;

    invoke-direct {v6, v5}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V

    invoke-virtual {p2, v6}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V

    .line 18
    invoke-virtual {v5}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 19
    .local v0, "crashReport":Ljava/lang/String;
    new-instance v3, Ljava/io/File;

    const-string v6, "/mnt/sdcard/libreDebug"

    invoke-direct {v3, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 20
    .local v3, "logFolder":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    .line 22
    :try_start_1b
    new-instance v2, Ljava/io/File;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v8

    invoke-virtual {v6, v8, v9}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, ".crashreport"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v2, v3, v6}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 23
    .local v2, "file":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->createNewFile()Z

    .line 24
    new-instance v4, Ljava/io/PrintWriter;

    invoke-direct {v4, v2}, Ljava/io/PrintWriter;-><init>(Ljava/io/File;)V

    .line 25
    .local v4, "printWriter":Ljava/io/PrintWriter;
    invoke-virtual {v4, v0}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V

    .line 26
    invoke-virtual {v4}, Ljava/io/PrintWriter;->close()V
    :try_end_45
    .catch Ljava/io/FileNotFoundException; {:try_start_1b .. :try_end_45} :catch_46
    .catch Ljava/io/IOException; {:try_start_1b .. :try_end_45} :catch_4b

    .line 33
    .end local v2    # "file":Ljava/io/File;
    .end local v4    # "printWriter":Ljava/io/PrintWriter;
    :goto_45
    return-void

    .line 27
    :catch_46
    move-exception v1

    .line 28
    .local v1, "ex":Ljava/io/FileNotFoundException;
    invoke-virtual {v1}, Ljava/io/FileNotFoundException;->printStackTrace()V

    goto :goto_45

    .line 29
    .end local v1    # "ex":Ljava/io/FileNotFoundException;
    :catch_4b
    move-exception v1

    .line 30
    .local v1, "ex":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_45
.end method
