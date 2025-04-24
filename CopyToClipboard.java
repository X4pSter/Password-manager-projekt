import java.awt.datatransfer.StringSelection;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;

public class CopyToClipboard{

    public void copy(String copiedText){
        StringSelection stringselection = new StringSelection(copiedText);
        Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
        clipboard.setContents(stringselection,null);
    }
}