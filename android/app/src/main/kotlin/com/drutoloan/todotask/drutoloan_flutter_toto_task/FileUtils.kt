package com.drutoloan.todotask.drutoloan_flutter_todo_task

import android.content.Context
import android.net.Uri
import java.io.File

object FileUtils {
    fun getPath(context: Context, uri: Uri): String? {
        val input = context.contentResolver.openInputStream(uri) ?: return null
        val file = File(context.cacheDir, "temp.json")
        input.use { inputStream ->
            file.outputStream().use { it.write(inputStream.readBytes()) }
        }
        return file.absolutePath
    }
}
