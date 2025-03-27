import javax.swing.*;
import java.io.*;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.swing .*;
import java.io.IOException;
import java.io.InputStream;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class WebScraping {
    public static void main(String[] args) throws IOException {
        URL urlAnexo1 = new URL("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf");
        URL urlAnexo2 = new URL("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_II_DUT_2021_RN_465.2021_RN628.2025_RN629.2025.pdf");

        try (InputStream anexo1Stream = urlAnexo1.openStream();
             InputStream anexo2Stream = urlAnexo2.openStream()) {

            // Baixando arquivos
            TelaProgresso telaProgresso = new TelaProgresso();

            telaProgresso.atualizarDados(25, "Baixando AnexoI.pdf ...");
            Files.copy(anexo1Stream, Paths.get("AnexoI.pdf"), StandardCopyOption.REPLACE_EXISTING);

            telaProgresso.atualizarDados(50, "Baixando AnexoII.pdf");
            Files.copy(anexo2Stream, Paths.get("AnexoII.pdf"), StandardCopyOption.REPLACE_EXISTING);

            // Zipando arquivos
            telaProgresso.atualizarDados(99, "Zipando ...");
            FileOutputStream fout = new FileOutputStream("AnexosPDF.zip");
            ZipOutputStream zout = new ZipOutputStream(fout);

            // - Zipando anexo1
            ZipEntry ze = new ZipEntry("AnexoI.pdf");
            zout.putNextEntry(ze);
            byte[] bytes = Files.readAllBytes(Paths.get("AnexoI.pdf"));
            zout.write(bytes, 0, bytes.length);
            zout.closeEntry();

            // - Zipando anexo2
            ze = new ZipEntry("AnexoII.pdf");
            zout.putNextEntry(ze);
            bytes = Files.readAllBytes(Paths.get("AnexoII.pdf"));
            zout.write(bytes, 0, bytes.length);
            zout.closeEntry();

            zout.close();
            fout.close();

            telaProgresso.dispose();

            JOptionPane.showMessageDialog(null,
                    "Download concluído com sucesso! Os arquivos \'AnexoI.pdf\', \'AnexoII.pdf\' e \'AnexosPDF.zip\' podem ser acessados na pasta atual.",
                    "Sucesso!", JOptionPane.INFORMATION_MESSAGE);
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, "Problema ao baixar os arquivos",
                    "Erro", JOptionPane.ERROR_MESSAGE);
        }
    }
}
