public void Main()
    {
        int fileCount = 0;
        string[] FilesToProcess;
        while (fileCount == 0)
        {
            try
            {

                System.Threading.Thread.Sleep(10000);
                FilesToProcess = System.IO.Directory.GetFiles(Dts.Variables["FolderLocation"].Value.ToString(), "*.txt");
                fileCount = FilesToProcess.Length;

                if (fileCount != 0)
                {
                    for (int i = 0; i < fileCount; i++)
                    {
                        try
                        {

                            System.IO.FileStream fs = new System.IO.FileStream(FilesToProcess[i], System.IO.FileMode.Open);
                            fs.Close();

                        }
                        catch (System.IO.IOException ex)
                        {
                            fileCount = 0;
                            continue;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        // TODO: Add your code here
        Dts.TaskResult = (int)ScriptResults.Success;
    }
}
}