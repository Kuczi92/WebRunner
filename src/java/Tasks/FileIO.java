/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tasks;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 *
 * @author Quchi
 */
public class FileIO {
    

public static byte[] getBytesFromInputStream(InputStream is,int Size) throws IOException
{
    try (ByteArrayOutputStream os = new ByteArrayOutputStream();)
    {
        byte[] buffer = new byte[Size];

        for (int len; (len = is.read(buffer)) != -1;)
            os.write(buffer, 0, len);

        os.flush();

        return os.toByteArray();
    }
}
}
