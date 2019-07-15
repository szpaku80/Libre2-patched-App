.class public Lcom/librelink/app/APKExtractor;
.super Ljava/lang/Object;
.source "APKExtractor.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static extractOriginalAPK(Landroid/app/Application;)V
    .registers 8
    .param p0, "application"    # Landroid/app/Application;

    .prologue
    .line 10
    invoke-static {p0}, Lcom/librelink/app/APKExtractor;->getOriginalAPKFile(Landroid/app/Application;)Ljava/io/File;

    move-result-object v2

    .line 11
    .local v2, "file":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_2b

    .line 13
    :try_start_a
    invoke-virtual {p0}, Landroid/app/Application;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v5

    const-string v6, "original.apk"

    invoke-virtual {v5, v6}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v3

    .line 14
    .local v3, "inputStream":Ljava/io/InputStream;
    invoke-virtual {v3}, Ljava/io/InputStream;->available()I

    move-result v5

    new-array v0, v5, [B

    .line 15
    .local v0, "bytes":[B
    invoke-virtual {v3, v0}, Ljava/io/InputStream;->read([B)I

    .line 16
    invoke-virtual {v3}, Ljava/io/InputStream;->close()V

    .line 17
    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 18
    .local v4, "outputStream":Ljava/io/OutputStream;
    invoke-virtual {v4, v0}, Ljava/io/OutputStream;->write([B)V

    .line 19
    invoke-virtual {v4}, Ljava/io/OutputStream;->close()V
    :try_end_2b
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_2b} :catch_2c

    .line 24
    .end local v0    # "bytes":[B
    .end local v3    # "inputStream":Ljava/io/InputStream;
    .end local v4    # "outputStream":Ljava/io/OutputStream;
    :cond_2b
    :goto_2b
    return-void

    .line 20
    :catch_2c
    move-exception v1

    .line 21
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_2b
.end method

.method public static getOriginalAPKFile(Landroid/app/Application;)Ljava/io/File;
    .registers 4
    .param p0, "application"    # Landroid/app/Application;

    .prologue
    .line 27
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/app/Application;->getNoBackupFilesDir()Ljava/io/File;

    move-result-object v1

    const-string v2, "original.apk"

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v0
.end method

.method public static getOriginalAPKPath(Landroid/app/Application;)Ljava/lang/String;
    .registers 2
    .param p0, "application"    # Landroid/app/Application;

    .prologue
    .line 31
    invoke-static {p0}, Lcom/librelink/app/APKExtractor;->getOriginalAPKFile(Landroid/app/Application;)Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
