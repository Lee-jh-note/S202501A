package org.oracle.s202501a.entity.jh_entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "price_history")
@ToString
@SequenceGenerator( name = "price_seq",
        sequenceName = "price_seq",
        allocationSize = 1)
public class PriceHistory {

    @Id
    @Column(name = "price_code")
    @GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator = "price_seq")
    private Long id;

    private Long product_no;
    private String from_date;
    private String to_date;
    private int sale_or_purchase;
    private int price;

    @Column(name = "reg_date", nullable = false, columnDefinition = "DATE DEFAULT sysdate")
    private Date reg_date;

    @PrePersist
    public void prePersist() {
        this.reg_date = this.reg_date == null ? new Date() : this.reg_date;
        this.from_date = new SimpleDateFormat("yy/MM/dd").format(new Date());
        this.to_date = "99/12/31";
    }


}
