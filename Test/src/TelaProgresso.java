import javax.swing.*;

public class TelaProgresso extends JFrame {
    private JProgressBar barraProgresso;
    private JLabel status;

    public TelaProgresso() {
        super("Progresso");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setSize(300, 160);
        setLayout(null);

        barraProgresso = new JProgressBar(SwingConstants.HORIZONTAL, 0, 100);
        barraProgresso.setString("0%");
        barraProgresso.setValue(0);
        barraProgresso.setStringPainted(true);
        barraProgresso.setBounds(25, 40, 250, 30);

        status = new JLabel();
        status.setBounds(25, 80, 250, 30);

        add(barraProgresso);
        add(status);
        setLocationRelativeTo(null);
        setVisible(true);
    }

    public void atualizarDados(int valorBarra, String textoStatus) {
        barraProgresso.setValue(valorBarra);
        barraProgresso.setString(valorBarra + "%");
        status.setText(textoStatus);
    }
}
