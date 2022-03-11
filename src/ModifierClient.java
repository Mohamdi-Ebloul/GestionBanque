import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.swing.*;
public class ModifierClient extends JFrame {
	Container c;
	JLabel l1,l2,l3,l4,l,l6;
	static JTextField t1,t2,t3,t4;
	JButton b,b1;
	JList list;
	JPanel p,p1;
	
	public ModifierClient() {
		c=this.getContentPane();
		setLayout(new FlowLayout());
		p=new JPanel();
		p1=new JPanel();
		l= new JLabel("Modifier un Client");
		l1= new JLabel("Nom de collonne");
		l2= new JLabel("Valeur");
		l3= new JLabel("id de client");
		t1= new JTextField(50);
		t2= new JTextField(50);
		t3= new JTextField(50);
		b=new JButton("Modifier");
		l.setVerticalAlignment(JLabel.TOP);
		
		p.setLayout(new GridLayout(11, 10));
		p1.setLayout(new GridLayout(3, 2));
        add(l);
		add(p);
		
		
		p.add(l1);p.add(t1);
		p.add(l2);p.add(t2);
		p.add(l3);p.add(t3);
		p.add(b);
		
		
		l.setFont(new java.awt.Font("Times New Roman", 0, 24));
		b.setFont(new java.awt.Font("Times New Roman", 0, 20)); // 
		b.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                bActionPerformed(evt);
            }
            
        });
		

		setSize(510,510);
		setVisible(true);
	}
	private void bActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
		String driver="oracle.jdbc.OracleDriver";
		String jdbc_url="jdbc:oracle:thin:@//localhost:1521/XE";
		String user="System";
		String pwd="12345678";
		
		 try {
	        	Class.forName(driver);
	    		Connection con=DriverManager.getConnection(jdbc_url,user,pwd);
	    		CallableStatement st=con.prepareCall("{CALL MODIFIERECLIENT(?,?,?)}");
	    		st.setString(1, t1.getText());
	    		st.setString(2, t2.getText());
	    		st.setString(3, t3.getText());
	    		
	    		st.execute();
	        	JOptionPane.showMessageDialog(this, "Copmte créé avec succès");
	        } catch (Exception e) {
	            JOptionPane.showMessageDialog(null, "ereur operation");
	        }


    }//GEN-LAST:event_jButton5ActionPerformed



}